<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Purchases extends CI_Model {
	public function __construct()
	{
		parent::__construct();
		$this->load->library('Smsgateway');
	}
	//Count purchase
	public function count_purchase()
	{
		$this->db->select('a.*,b.manufacturer_name');
		$this->db->from('product_purchase a');
		$this->db->join('manufacturer_information b','b.manufacturer_id = a.manufacturer_id');
		$this->db->order_by('a.purchase_date','desc');
		$query = $this->db->get();
		
		$last_query =  $this->db->last_query();
		if ($query->num_rows() > 0) {
			return $query->num_rows();	
		}
		return false;
	}

	  public function getPurchaseList($postData=null){
         $this->load->library('occational');
         $this->load->model('Web_settings');
         $currency_details = $this->Web_settings->retrieve_setting_editdata();
         $response = array();
         $fromdate = $this->input->post('fromdate',true);
         $todate   = $this->input->post('todate',true);
         if(!empty($fromdate)){
            $datbetween = "(a.purchase_date BETWEEN '$fromdate' AND '$todate')";
         }else{
            $datbetween = "";
         }
         ## Read value
         $draw = $postData['draw'];
         $start = $postData['start'];
         $rowperpage = $postData['length']; // Rows display per page
         $columnIndex = $postData['order'][0]['column']; // Column index
         $columnName = $postData['columns'][$columnIndex]['data']; // Column name
         $columnSortOrder = $postData['order'][0]['dir']; // asc or desc
         $searchValue = $postData['search']['value']; // Search value

         ## Search 
         $searchQuery = "";
         if($searchValue != ''){
            $searchQuery = " (b.manufacturer_name like '%".$searchValue."%' or a.chalan_no like '%".$searchValue."%' or a.purchase_date like'%".$searchValue."%')";
         }

         ## Total number of records without filtering
        $this->db->select('count(*) as allcount');
        $this->db->from('product_purchase a');
        $this->db->join('manufacturer_information b', 'b.manufacturer_id = a.manufacturer_id','left');
          if(!empty($fromdate) && !empty($todate)){
             $this->db->where($datbetween);
         }
          if($searchValue != '')
          $this->db->where($searchQuery);
          
         $records = $this->db->get()->result();
         $totalRecords = $records[0]->allcount;

         ## Total number of record with filtering
         $this->db->select('count(*) as allcount');
        $this->db->from('product_purchase a');
        $this->db->join('manufacturer_information b', 'b.manufacturer_id = a.manufacturer_id','left');
         if(!empty($fromdate) && !empty($todate)){
             $this->db->where($datbetween);
         }
         if($searchValue != '')
            $this->db->where($searchQuery);
          
         $records = $this->db->get()->result();
         $totalRecordwithFilter = $records[0]->allcount;

         ## Fetch records
        $this->db->select('a.*,b.manufacturer_name');
        $this->db->from('product_purchase a');
        $this->db->join('manufacturer_information b', 'b.manufacturer_id = a.manufacturer_id','left');
          if(!empty($fromdate) && !empty($todate)){
             $this->db->where($datbetween);
         }
         if($searchValue != '')
         $this->db->where($searchQuery);
       
         $this->db->order_by($columnName, $columnSortOrder);
         $this->db->limit($rowperpage, $start);
         $records = $this->db->get()->result();

         // Status perbandingan harga untuk seluruh nota di halaman ini.
         $purchase_ids = array();
         foreach($records as $record){
            $purchase_ids[] = $record->purchase_id;
         }
         $price_status = $this->purchase_price_status_bulk($purchase_ids);

         // Rincian barang untuk seluruh nota di halaman ini.
         // Diambil sekali jalan (1 query) supaya halaman tidak berat.
         $items = array();
         if(!empty($purchase_ids)){
            $this->db->select('d.purchase_id, d.batch_id, d.expeire_date,
                               d.quantity, d.rate, d.discount, d.total_amount,
                               p.product_name');
            $this->db->from('product_purchase_details d');
            $this->db->join('product_information p','p.product_id = d.product_id','left');
            $this->db->where_in('d.purchase_id', $purchase_ids);
            $this->db->order_by('d.id','asc');
            foreach($this->db->get()->result() as $it){
               $items[$it->purchase_id][] = $it;
            }
         }

         $data = array();
         $sl =1;
         foreach($records as $record ){
          $button = '';
          $base_url = base_url();
          $jsaction = "return confirm('Are You Sure ?')";

           $button .='  <a href="'.$base_url.'Cpurchase/invoice_html/'.$record->purchase_id.'" class="btn btn-success btn-sm" data-toggle="tooltip" data-placement="left" title="'.display('purchase_details').'"><i class="fa fa-window-restore" aria-hidden="true"></i></a>';
      if($this->permission1->method('manage_purchase','update')->access()){
         $button .=' <a href="'.$base_url.'Cpurchase/purchase_update_form/'.$record->purchase_id.'" class="btn btn-info btn-sm" data-toggle="tooltip" data-placement="left" title="'. display('update').'"><i class="fa fa-pencil" aria-hidden="true"></i></a> ';
     }

      
               
            // Kolom status: ringkasan naik/turun/sama dibanding harga
            // pembelian sebelumnya untuk obat + distributor yang sama.
            $st     = (isset($price_status[$record->purchase_id])
                        ? $price_status[$record->purchase_id]
                        : array('naik'=>0,'turun'=>0,'sama'=>0,'baru'=>0));
            $status = '';

            if ($st['naik'] > 0) {
               $status .= '<span class="label" style="background:#d9534f;color:#fff;margin-right:3px;" title="'.$st['naik'].' obat harganya naik">'
                        . '<i class="fa fa-arrow-up"></i> '.$st['naik'].'</span>';
            }
            if ($st['turun'] > 0) {
               $status .= '<span class="label" style="background:#5cb85c;color:#fff;margin-right:3px;" title="'.$st['turun'].' obat harganya turun">'
                        . '<i class="fa fa-arrow-down"></i> '.$st['turun'].'</span>';
            }
            if ($st['sama'] > 0) {
               $status .= '<span class="label" style="background:#f0ad4e;color:#fff;margin-right:3px;" title="'.$st['sama'].' obat harganya sama">'
                        . '<i class="fa fa-minus"></i> '.$st['sama'].'</span>';
            }
            if ($st['baru'] > 0) {
               $status .= '<span class="label" style="background:#777;color:#fff;margin-right:3px;" title="'.$st['baru'].' obat belum punya riwayat harga">'
                        . '<i class="fa fa-star-o"></i> '.$st['baru'].'</span>';
            }
            if ($status === '') {
               $status = '<span class="text-muted">-</span>';
            }

            // Kolom rincian barang. Satu nota bisa berisi banyak barang,
            // jadi tiap sel menampilkannya baris per baris.
            $c_nama = array(); $c_batch = array(); $c_exp = array();
            $c_qty = array(); $c_rate = array(); $c_disc = array(); $c_total = array();

            if(isset($items[$record->purchase_id])){
               foreach($items[$record->purchase_id] as $it){
                  $c_nama[]  = html_escape($it->product_name);
                  $c_batch[] = ($it->batch_id != '' ? html_escape($it->batch_id) : '-');
                  $c_exp[]   = ($it->expeire_date != '' ? html_escape($it->expeire_date) : '-');
                  $c_qty[]   = (float)$it->quantity;
                  $c_rate[]  = number_format((float)$it->rate, 2, '.', ',');
                  $c_disc[]  = (float)$it->discount.'%';
                  $c_total[] = number_format((float)$it->total_amount, 2, '.', ',');
               }
            }

            $data[] = array(
                'sl'               =>$sl,
                'chalan_no'        =>$record->chalan_no,
                'purchase_id'      =>$record->purchase_id,
                'manufacturer_name'=>$record->manufacturer_name,
                'purchase_id'      =>$record->purchase_id,
                'purchase_date'    =>$record->purchase_date,
                'product_name'     =>(!empty($c_nama) ? implode('<br>', $c_nama) : '-'),
                'batch_id'         =>(!empty($c_batch) ? implode('<br>', $c_batch) : '-'),
                'expeire_date'     =>(!empty($c_exp) ? implode('<br>', $c_exp) : '-'),
                'product_qty'      =>(!empty($c_qty) ? implode('<br>', $c_qty) : '-'),
                'product_rate'     =>(!empty($c_rate) ? implode('<br>', $c_rate) : '-'),
                'product_discount' =>(!empty($c_disc) ? implode('<br>', $c_disc) : '-'),
                'product_total'    =>(!empty($c_total) ? implode('<br>', $c_total) : '-'),
                'total_amount'     =>$record->grand_total_amount,
                'status'           =>$status,
                'button'           =>$button,

            );
            $sl++;
         }

         ## Response
         $response = array(
            "draw" => intval($draw),
            "iTotalRecords" => $totalRecordwithFilter,
            "iTotalDisplayRecords" => $totalRecords,
            "aaData" => $data
         );

         return $response; 
    }
	//purchase List
	public function purchase_list($per_page,$page)
	{
		$this->db->select('a.*,b.manufacturer_name');
		$this->db->from('product_purchase a');
		$this->db->join('manufacturer_information b','b.manufacturer_id = a.manufacturer_id');
		$this->db->order_by('a.purchase_date','desc');
		$this->db->order_by('purchase_id','desc');
		$this->db->limit($per_page,$page);
		$query = $this->db->get();
		
		$last_query =  $this->db->last_query();
		if ($query->num_rows() > 0) {
			return $query->result_array();
		}
		return false;
	}
//purchase info by invoice id
 public function purchase_list_invoice_id($invoice_no)
	{
		$this->db->select('a.*,b.manufacturer_name');
		$this->db->from('product_purchase a');
		$this->db->join('manufacturer_information b','b.manufacturer_id = a.manufacturer_id');
		$this->db->where('a.chalan_no',$invoice_no);
		$this->db->order_by('a.purchase_date','desc');
		$this->db->order_by('purchase_id','desc');
		$query = $this->db->get();
		
		$last_query =  $this->db->last_query();
		if ($query->num_rows() > 0) {
			return $query->result_array();	
		}
		return false;
	}
	//Select All manufacturer List
	public function select_all_manufacturer()
	{
		$query = $this->db->select('*')
					->from('manufacturer_information')
					->where('status','1')
					->get();
		if ($query->num_rows() > 0) {
			return $query->result_array();	
		}
		return false;
	}

	//purchase Search  List
	public function purchase_by_search($manufacturer_id)
	{
		$this->db->select('a.*,b.manufacturer_name');
		$this->db->from('product_purchase a');
		$this->db->join('manufacturer_information b','b.manufacturer_id = a.manufacturer_id');
		$this->db->where('b.manufacturer_id',$manufacturer_id);
		$query = $this->db->get();
		if ($query->num_rows() > 0) {
			return $query->result_array();	
		}
		return false;
	}
	/**
	 * Ambil akun COA milik distributor; buat dulu bila belum ada.
	 *
	 * Distributor yang ditambahkan lewat form selalu dibuatkan baris
	 * `acc_coa` oleh Cmanufacturer.php. Distributor hasil impor massal
	 * tidak melalui proses itu, sehingga COA-nya kosong dan
	 * $manuf_coa->HeadCode menjadi NULL -> INSERT ke acc_transaction
	 * gagal dengan "Column 'COAID' cannot be null".
	 *
	 * @param  int $manufacturer_id
	 * @return object|null baris acc_coa, atau NULL bila distributor tak ada
	 */
	private function get_or_create_manufacturer_coa($manufacturer_id)
	{
		$coa = $this->db->select('*')->from('acc_coa')
		                ->where('manufacturer_id', $manufacturer_id)
		                ->get()->row();
		if (!empty($coa)) {
			return $coa;
		}

		$manufacturer = $this->db->select('manufacturer_name')
		                         ->from('manufacturer_information')
		                         ->where('manufacturer_id', $manufacturer_id)
		                         ->get()->row();
		if (empty($manufacturer)) {
			return NULL;
		}

		// Penomoran mengikuti Manufacturers::headcode()
		$last = $this->db->query("SELECT MAX(CAST(HeadCode AS UNSIGNED)) AS HeadCode
		                            FROM acc_coa
		                           WHERE HeadLevel='3' AND HeadCode LIKE '50200%'")->row();
		$headcode = (!empty($last) && $last->HeadCode != NULL) ? ($last->HeadCode + 1) : 502000001;

		$this->db->insert('acc_coa', array(
			'HeadCode'         => $headcode,
			'HeadName'         => $manufacturer->manufacturer_name.'-'.$manufacturer_id,
			'PHeadName'        => 'Account Payable',
			'HeadLevel'        => '3',
			'IsActive'         => '1',
			'IsTransaction'    => '1',
			'IsGL'             => '0',
			'HeadType'         => 'L',
			'IsBudget'         => '0',
			'manufacturer_id'  => $manufacturer_id,
			'IsDepreciation'   => '0',
			'DepreciationRate' => '0',
			'CreateBy'         => $this->session->userdata('user_id'),
			'CreateDate'       => date('Y-m-d H:i:s'),
			'UpdateBy'         => '',
			'UpdateDate'       => '0000-00-00 00:00:00',
		));

		return $this->db->select('*')->from('acc_coa')
		                ->where('manufacturer_id', $manufacturer_id)
		                ->get()->row();
	}

	//Count purchase
	/**
	 * Hitung diskon keseluruhan dan PPN pembelian di sisi server.
	 *
	 * Subtotal dijumlahkan ulang dari total_price[] tiap barang, bukan dari
	 * grand_total_price kiriman form, karena nilai form bisa diubah lewat
	 * browser.
	 *
	 * Urutan:
	 *   Dasar Pengenaan = Sub Total - Diskon Keseluruhan
	 *   Grand Total     = Dasar Pengenaan + PPN
	 *
	 * PPN dihitung sesudah diskon karena dasar pengenaan pajak adalah nilai
	 * transaksi bersih, yaitu sesudah potongan harga.
	 *
	 * @return array type, input, amount, ppn_*, sub_total, dpp, grand_total
	 */
	public function calculate_overall_discount()
	{
		$total_prices = $this->input->post('total_price', true);
		$sub_total = 0;
		if (is_array($total_prices)) {
			foreach ($total_prices as $tp) {
				$sub_total += (float) $tp;
			}
		}

		$type  = $this->input->post('overall_discount_type', true);
		$type  = ($type === 'fixed' ? 'fixed' : 'percent');
		$input = (float) $this->input->post('overall_discount_input', true);
		if ($input < 0) {
			$input = 0;
		}

		if ($type === 'percent') {
			if ($input > 100) {
				$input = 100;
			}
			$amount = $sub_total * $input / 100;
		} else {
			$amount = $input;
		}

		// Diskon tidak boleh melebihi subtotal.
		if ($amount > $sub_total) {
			$amount = $sub_total;
		}

		// Dasar pengenaan pajak: nilai bersih sesudah diskon.
		$dpp = $sub_total - $amount;

		// ---- PPN ----
		$ppn_type  = $this->input->post('ppn_type', true);
		$ppn_type  = ($ppn_type === 'fixed' ? 'fixed' : 'percent');
		$ppn_input = (float) $this->input->post('ppn_input', true);
		if ($ppn_input < 0) {
			$ppn_input = 0;
		}

		if ($ppn_type === 'percent') {
			if ($ppn_input > 100) {
				$ppn_input = 100;
			}
			$ppn_amount = $dpp * $ppn_input / 100;
		} else {
			$ppn_amount = $ppn_input;
		}

		return array(
			'type'        => $type,
			'input'       => $input,
			'amount'      => round($amount, 2),
			'ppn_type'    => $ppn_type,
			'ppn_input'   => $ppn_input,
			'ppn_amount'  => round($ppn_amount, 2),
			'sub_total'   => round($sub_total, 2),
			'dpp'         => round($dpp, 2),
			// PPN menambah, jadi grand total = dasar pengenaan + PPN.
			'grand_total' => round($dpp + $ppn_amount, 2),
		);
	}

	public function purchase_entry()
	{
		$purchase_id = date('YmdHis');
		$p_id = $this->input->post('product_id',true);
		$chaln_no=$this->input->post('chalan_no',true);
		$manufacturer_id=$this->input->post('manufacturer_id',true);
		$manufacturer_info = $this->db->select('*')->from('manufacturer_information')->where('manufacturer_id',$manufacturer_id)->get()->row(); 
        // Buat akun COA distributor bila belum ada, supaya COAID tidak NULL.
        $manuf_coa = $this->get_or_create_manufacturer_coa($manufacturer_id);
       $receive_by=$this->session->userdata('user_id');
        $receive_date=date('Y-m-d');
        $createdate=date('Y-m-d H:i:s');
     $bank_id = $this->input->post('bank_id',true);
     // Selalu terdefinisi: pembelian tunai tidak mengisi bank_id, sedangkan
     // $bankcoaid tetap dibaca saat menyusun array $bankc di bawah.
     $bankcoaid = NULL;
        if(!empty($bank_id)){
       $bankrow = $this->db->select('bank_name')->from('bank_add')->where('bank_id',$bank_id)->get()->row();
       if(!empty($bankrow)){
       $bankname = $bankrow->bank_name;
       $bankcoarow = $this->db->select('HeadCode')->from('acc_coa')->where('HeadName',$bankname)->get()->row();
       $bankcoaid = (!empty($bankcoarow) ? $bankcoarow->HeadCode : NULL);
       }
   }

    	$this->form_validation->set_rules('manufacturer_id', 'Manufacturer Name', 'required');
		$this->form_validation->set_rules('paytype', 'Pyament Type', 'required');
		$this->form_validation->set_rules('product_id[]', 'Medicine Name', 'required');
		$this->form_validation->set_rules('batch_id[]', 'Batch Id', 'required');
		$this->form_validation->set_rules('expeire_date[]', 'Expiry Date', 'required');
		$this->form_validation->set_rules('product_quantity[]', 'Quantity', 'required');
		
		if ($this->form_validation->run()) {

		$this->db->select('*');
		$this->db->from('product_purchase');
		$this->db->where('status',1);
		$this->db->where('chalan_no',$chaln_no);
		$this->db->where('manufacturer_id',$manufacturer_id);
		$query = $this->db->get();
		if ($query->num_rows() > 0) {
			 $this->session->set_flashdata('error_message',display('Choose_another_invno'));
			  	redirect(base_url('Cpurchase'));
			  	exit();
		}

		// Obat tidak lagi diikat ke distributor, jadi pembelian obat apa pun
		// dari distributor mana pun diperbolehkan.

		// Diskon keseluruhan dihitung ulang di server, tidak memakai angka
		// kiriman form (nilai itu bisa diubah dari browser). Nilai inilah
		// yang dipakai untuk grand total dan seluruh jurnal akuntansi.
		$overall = $this->calculate_overall_discount();

		$data=array(
			'purchase_id'		=>	$purchase_id,
			'chalan_no'			=>	$this->input->post('chalan_no',true),
			'manufacturer_id'	=>	$this->input->post('manufacturer_id',true),
			'grand_total_amount'=>	$overall['grand_total'],
			'total_discount'	=>	$this->input->post('total_discount',true),
			'overall_discount_type'   => $overall['type'],
			'overall_discount_input'  => $overall['input'],
			'overall_discount_amount' => $overall['amount'],
			'ppn_type'                => $overall['ppn_type'],
			'ppn_input'               => $overall['ppn_input'],
			'ppn_amount'              => $overall['ppn_amount'],
			'purchase_date'		=>	$this->input->post('purchase_date',true),
			'purchase_details'	=>	$this->input->post('purchase_details',true),
			'status'			=>	1,
			'bank_id'           =>  $this->input->post('bank_id',true),
			'payment_type'      =>  $this->input->post('paytype',true),
		);
		$this->db->insert('product_purchase',$data);

		// Dipakai berulang di seluruh jurnal di bawah.
		$grand_total_price = $overall['grand_total'];
		//manufacturer credit
		     $purchasecoatran = array(
          'VNo'            =>  $purchase_id,
          'Vtype'          =>  'Purchase',
          'VDate'          =>  $this->input->post('purchase_date',true),
          'COAID'          =>  $manuf_coa->HeadCode,
          'Narration'      =>  'Purchase No.'.$purchase_id,
          'Debit'          =>  0,
          'Credit'         =>  $grand_total_price,
          'IsPosted'       =>  1,
          'CreateBy'       =>  $receive_by,
          'CreateDate'     =>  $receive_date,
          'IsAppove'       =>  1
        ); 
          ///Inventory Debit
       $coscr = array(
      'VNo'            => $purchase_id,
      'Vtype'          => 'Purchase',
      'VDate'          => $this->input->post('purchase_date',true),
      'COAID'          => 10107,
      'Narration'      => 'Inventory Debit For Purchase No'.$purchase_id,
      'Debit'          => $grand_total_price,
      'Credit'         => 0,//purchase price asbe
      'IsPosted'       => 1,
      'CreateBy'       => $receive_by,
      'CreateDate'     => $createdate,
      'IsAppove'       => 1
    ); 
       // Expense for company
         $expense = array(
      'VNo'            => $purchase_id,
      'Vtype'          => 'Purchase',
      'VDate'          => $this->input->post('purchase_date',true),
      'COAID'          => 402,
      'Narration'      => 'Company Credit For Purchase No'.$purchase_id,
      'Debit'          => $grand_total_price,
      'Credit'         => 0,//purchase price asbe
      'IsPosted'       => 1,
      'CreateBy'       => $receive_by,
      'CreateDate'     => $createdate,
      'IsAppove'       => 1
    ); 
             $cashinhand = array(
      'VNo'            =>  $purchase_id,
      'Vtype'          =>  'Purchase',
      'VDate'          =>  $this->input->post('purchase_date',true),
      'COAID'          =>  1020101,
      'Narration'      =>  'Cash in Hand For Purchase No'.$purchase_id,
      'Debit'          =>  0,
      'Credit'         =>  $grand_total_price,
      'IsPosted'       =>  1,
      'CreateBy'       =>  $receive_by,
      'CreateDate'     =>  $createdate,
      'IsAppove'       =>  1
    ); 

     $manufacurerdebit = array(
          'VNo'            =>  $purchase_id,
          'Vtype'          =>  'Purchase',
          'VDate'          =>  $this->input->post('purchase_date',true),
          'COAID'          =>  $manuf_coa->HeadCode,
          'Narration'      =>  'Purchase No.'.$purchase_id,
          'Debit'          =>  $grand_total_price,
          'Credit'         =>  0,
          'IsPosted'       =>  1,
          'CreateBy'       =>  $receive_by,
          'CreateDate'     =>  $receive_date,
          'IsAppove'       =>  1
        ); 
             
                  // bank ledger
 $bankc = array(
      'VNo'            =>  $purchase_id,
      'Vtype'          =>  'Purchase',
      'VDate'          =>  $this->input->post('purchase_date',true),
      'COAID'          =>  $bankcoaid,
      'Narration'      =>  'Paid amount for Purchase No '.$purchase_id,
      'Debit'          =>  0,
      'Credit'         =>  $grand_total_price,
      'IsPosted'       =>  1,
      'CreateBy'       =>  $receive_by,
      'CreateDate'     =>  $createdate,
      'IsAppove'       =>  1
    ); 

		

	
		$this->db->insert('acc_transaction',$coscr);
		$this->db->insert('acc_transaction',$purchasecoatran);	
		$this->db->insert('acc_transaction',$expense);
		if($this->input->post('paytype') == 2){
       	$this->db->insert('acc_transaction',$bankc);
       	$this->db->insert('acc_transaction',$manufacurerdebit);
		}
		if($this->input->post('paytype') == 1){
		$this->db->insert('acc_transaction',$cashinhand);
		$this->db->insert('acc_transaction',$manufacurerdebit);		
		}		
		$rate = $this->input->post('product_rate',true);
		$quantity = $this->input->post('product_quantity',true);
		$t_price = $this->input->post('total_price',true);
		$discount = $this->input->post('discount',true);
		$batch=$this->input->post('batch_id',true);
		$exp_date=$this->input->post('expeire_date',true);
		
		for ($i=0, $n=count($p_id); $i < $n; $i++) {
			$product_quantity = $quantity[$i];
			$product_rate = $rate[$i];
			$product_id = $p_id[$i];
			$total_price = $t_price[$i];
			// Diskon per barang (persen). Aman bila field belum terkirim.
			$disc = (isset($discount[$i]) && $discount[$i] !== '' ? $discount[$i] : 0);
			$batch_id=$batch[$i];
			$expre_date=$exp_date[$i];

			$data1 = array(
				'purchase_detail_id'=>	$this->generator(15),
				'purchase_id'		=>	$purchase_id,
				'product_id'		=>	$product_id,
				'quantity'			=>	$product_quantity,
				'rate'				=>	$product_rate,
				'total_amount'		=>	$total_price,
				'discount'			=>	$disc,
				'batch_id'          =>  $batch_id,
				'expeire_date'      =>  $expre_date,
				'status'			=>	1
			);

			if(!empty($quantity))
			{
				$this->db->insert('product_purchase_details',$data1);
			}
		}
	
		   $message = 'Mr/Mrs. '.$manufacturer_info->manufacturer_name.',
        '.'You have Sold '.$grand_total_price;
           $config_data = $this->db->select('*')->from('sms_settings')->get()->row();
        if($config_data->ispurchase == 1){
          $this->smsgateway->send([
            'apiProvider' => 'nexmo',
            'username'    => $config_data->api_key,
            'password'    => $config_data->api_secret,
            'from'        => $config_data->from,
            'to'          => $manufacturer_info->mobile,
            'message'     => $message
        ]);
      }
		return $purchase_id;
		 }else{
        $this->session->set_userdata(array('error_message' => validation_errors()));
         redirect($_SERVER['HTTP_REFERER']);
    }
	
	}

	//Retrieve purchase Edit Data
	public function retrieve_purchase_editdata($purchase_id)
	{
		$this->db->select('a.*,
						b.*,
						c.product_id,
						c.product_name,
						c.product_model,
						d.manufacturer_id,
						d.manufacturer_name'
						);
		$this->db->from('product_purchase a');
		$this->db->join('product_purchase_details b','b.purchase_id =a.purchase_id');
		$this->db->join('product_information c','c.product_id =b.product_id');
		$this->db->join('manufacturer_information d','d.manufacturer_id = a.manufacturer_id');
		$this->db->where('a.purchase_id',$purchase_id);
		$this->db->order_by('a.purchase_details','asc');
		$query = $this->db->get();
		if ($query->num_rows() > 0) {
			return $query->result_array();	
		}
		return false;
	}
	//Retrieve company Edit Data
	public function retrieve_company()
	{
		$this->db->select('*');
		$this->db->from('company_information');
		$this->db->limit('1');
		$query = $this->db->get();
		if ($query->num_rows() > 0) {
			return $query->result_array();	
		}
		return false;
	}
	//Update Categories
public function update_purchase()
	{
	$purchase_id  = $this->input->post('purchase_id',true);
     $bank_id = $this->input->post('bank_id',true);
        if(!empty($bank_id)){
       $bankname = $this->db->select('bank_name')->from('bank_add')->where('bank_id',$bank_id)->get()->row()->bank_name;
    
       $bankcoaid = $this->db->select('HeadCode')->from('acc_coa')->where('HeadName',$bankname)->get()->row()->HeadCode;
   }
   $manufacturer_id=$this->input->post('manufacturer_id');
//manufacturer coa head
		$manufacturer_info = $this->db->select('*')->from('manufacturer_information')->where('manufacturer_id',$manufacturer_id)->get()->row(); 
        // Buat akun COA distributor bila belum ada, supaya COAID tidak NULL.
        $manuf_coa = $this->get_or_create_manufacturer_coa($manufacturer_id);

        $receive_by=$this->session->userdata('user_id');
        $receive_date=date('Y-m-d');
        $createdate=date('Y-m-d H:i:s');
  
		// Sama seperti saat simpan baru: diskon keseluruhan dihitung ulang
		// di server, bukan memakai angka kiriman form.
		$overall = $this->calculate_overall_discount();
		$grand_total_price = $overall['grand_total'];

		$data=array(
			'purchase_id'       =>  $purchase_id,
			'chalan_no'			=>	$this->input->post('chalan_no',true),
			'manufacturer_id'	=>	$this->input->post('manufacturer_id',true),
			'grand_total_amount'=>	$grand_total_price,
			'total_discount'	=>	$this->input->post('total_discount',true),
			'overall_discount_type'   => $overall['type'],
			'overall_discount_input'  => $overall['input'],
			'overall_discount_amount' => $overall['amount'],
			'ppn_type'                => $overall['ppn_type'],
			'ppn_input'               => $overall['ppn_input'],
			'ppn_amount'              => $overall['ppn_amount'],
			'purchase_date'		=>	$this->input->post('purchase_date',true),
			'purchase_details'	=>	$this->input->post('purchase_details',true),
			'bank_id'           =>  $this->input->post('bank_id',true),
			'payment_type'      =>  $this->input->post('paytype',true),
		);
           $cashinhand = array(
      'VNo'            =>  $purchase_id,
      'Vtype'          =>  'Purchase',
      'VDate'          =>  $this->input->post('purchase_date',true),
      'COAID'          =>  1020101,
      'Narration'      =>  'Cash in Hand For Purchase No'.$purchase_id,
      'Debit'          =>  0,
      'Credit'         =>  $grand_total_price,
      'IsPosted'       =>  1,
      'CreateBy'       =>  $receive_by,
      'CreateDate'     =>  $createdate,
      'IsAppove'       =>  1
    ); 
                  // bank ledger
 $bankc = array(
      'VNo'            =>  $purchase_id,
      'Vtype'          =>  'Purchase',
      'VDate'          =>  $this->input->post('purchase_date',true),
      'COAID'          =>  $bankcoaid,
      'Narration'      =>  'Paid amount for Purchase No '.$purchase_id,
      'Debit'          =>  0,
      'Credit'         =>  $grand_total_price,
      'IsPosted'       =>  1,
      'CreateBy'       =>  $receive_by,
      'CreateDate'     =>  $createdate,
      'IsAppove'       =>  1
    ); 


 		     $purchasecoatran = array(
          'VNo'            =>  $purchase_id,
          'Vtype'          =>  'Purchase',
          'VDate'          =>  $this->input->post('purchase_date',true),
          'COAID'          =>  $manuf_coa->HeadCode,
          'Narration'      =>  'Purchase No.'.$purchase_id,
          'Debit'          =>  0,
          'Credit'         =>  $grand_total_price,
          'IsPosted'       =>  1,
          'CreateBy'       =>  $receive_by,
          'CreateDate'     =>  $receive_date,
          'IsAppove'       =>  1
        ); 
 		     $manufacurerdebit = array(
          'VNo'            =>  $purchase_id,
          'Vtype'          =>  'Purchase',
          'VDate'          =>  $this->input->post('purchase_date',true),
          'COAID'          =>  $manuf_coa->HeadCode,
          'Narration'      =>  'Purchase No.'.$purchase_id,
          'Debit'          =>  $grand_total_price,
          'Credit'         =>  0,
          'IsPosted'       =>  1,
          'CreateBy'       =>  $receive_by,
          'CreateDate'     =>  $receive_date,
          'IsAppove'       =>  1
        ); 
          ///Inventory Debit
       $coscr = array(
      'VNo'            => $purchase_id,
      'Vtype'          => 'Purchase',
      'VDate'          => $this->input->post('purchase_date',true),
      'COAID'          => 10107,
      'Narration'      => 'Inventory Debit For Purchase No'.$purchase_id,
      'Debit'          => $grand_total_price,
      'Credit'         => 0,//purchase price asbe
      'IsPosted'       => 1,
      'CreateBy'       => $receive_by,
      'CreateDate'     => $createdate,
      'IsAppove'       => 1
    ); 
       // Expense for company
         $expense = array(
      'VNo'            => $purchase_id,
      'Vtype'          => 'Purchase',
      'VDate'          => $this->input->post('purchase_date',true),
      'COAID'          => 402,
      'Narration'      => 'Company Credit For Purchase No'.$purchase_id,
      'Debit'          => $grand_total_price,
      'Credit'         => 0,//purchase price asbe
      'IsPosted'       => 1,
      'CreateBy'       => $receive_by,
      'CreateDate'     => $createdate,
      'IsAppove'       => 1
    ); 

		if($purchase_id!='')
		{
			$this->db->where('purchase_id',$purchase_id);
			$this->db->update('product_purchase',$data); 
		    $this->db->where('purchase_id',$purchase_id);
			$this->db->delete('product_purchase_details');
			$this->db->where('VNo',$purchase_id);
			$this->db->delete('acc_transaction');
			$this->db->insert('acc_transaction',$coscr);
		    $this->db->insert('acc_transaction',$purchasecoatran);	
		    $this->db->insert('acc_transaction',$expense);
		    //bank summary
        
			if($this->input->post('paytype',true) == 2){
       	$this->db->insert('acc_transaction',$bankc);
       	$this->db->insert('acc_transaction',$manufacurerdebit);	
		}
		if($this->input->post('paytype',true) == 1){
		$this->db->insert('acc_transaction',$cashinhand);
		$this->db->insert('acc_transaction',$manufacurerdebit);			
		}		
		}
		
		$rate     = $this->input->post('product_rate',true);
		$p_id     = $this->input->post('product_id',true);
		$quantity = $this->input->post('product_quantity',true);
		$t_price  = $this->input->post('total_price',true);
		$discount = $this->input->post('discount',true);
        $batch    = $this->input->post('batch_id',true);
		$exp_date = $this->input->post('expeire_date',true);
		for ($i=0, $n=count($p_id); $i < $n; $i++) {
			$product_quantity = $quantity[$i];
			$product_rate = $rate[$i];
			$product_id   = $p_id[$i];
			$total_price  = $t_price[$i];
			$batch_id     = $batch[$i];
			$expre_date   = $exp_date[$i];
			// Diskon per barang (persen). Aman bila field belum terkirim.
			$disc = (isset($discount[$i]) && $discount[$i] !== '' ? $discount[$i] : 0);


			$data1 = array(
				'purchase_detail_id'=> $this->generator(15),
				'purchase_id'       =>  $purchase_id,
				'product_id'		=>	$product_id,
				'quantity'			=>	$product_quantity,
				'rate'				=>	$product_rate,
				'batch_id'          =>  $batch_id,
				'expeire_date'      =>  $expre_date,
				'total_amount'		=>	$total_price,
				'discount'			=>	$disc,
			);

			
			if(($quantity))
			{
				
				$this->db->insert('product_purchase_details',$data1); 
			}
		}
		return $purchase_id;
	}
	// Delete purchase Item
	
	public function purchase_search_list($cat_id,$company_id)
	{
		$this->db->select('a.*,b.sub_category_name,c.category_name');
		$this->db->from('purchases a');
		$this->db->join('purchase_sub_category b','b.sub_category_id = a.sub_category_id');
		$this->db->join('purchase_category c','c.category_id = b.category_id');
		$this->db->where('a.sister_company_id',$company_id);
		$this->db->where('c.category_id',$cat_id);
		$query = $this->db->get();
		if ($query->num_rows() > 0) {
			return $query->result_array();	
		}
		return false;
	}
	//Retrieve purchase_details_data
	public function purchase_details_data($purchase_id)
	{
	$this->db->select('a.*,b.*,c.*,e.purchase_details,d.product_id,d.product_name,d.strength,d.product_model');
		$this->db->from('product_purchase a');
		$this->db->join('manufacturer_information b','b.manufacturer_id = a.manufacturer_id');
		$this->db->join('product_purchase_details c','c.purchase_id = a.purchase_id');
		$this->db->join('product_information d','d.product_id = c.product_id');
		$this->db->join('product_purchase e','e.purchase_id = c.purchase_id');
		$this->db->where('a.purchase_id',$purchase_id);
		$this->db->group_by('d.product_id');
		$query = $this->db->get();
		if ($query->num_rows() > 0) {
			return $query->result_array();	
		}
		return false;
	}
	
	//This function will check the product & manufacturer relationship.
	public function product_manufacturer_check($product_id,$manufacturer_id)
	{
	 $this->db->select('*');
	  $this->db->from('product_information');
	  $this->db->where('product_id',$product_id);
	  $this->db->where('manufacturer_id',$manufacturer_id);	
	  $query = $this->db->get();
		if ($query->num_rows() > 0) {
			return true;	
		}
		return 0;
	}
	//This function is used to Generate Key
	public function generator($lenth)
	{
		$number=array("A","B","C","D","E","F","G","H","I","J","K","L","N","M","O","P","Q","R","S","U","V","T","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","1","2","3","4","5","6","7","8","9","0");
	
		for($i=0; $i<$lenth; $i++)
		{
			$rand_value=rand(0,61);
			$rand_number=$number["$rand_value"];
		
			if(empty($con))
			{ 
			$con=$rand_number;
			}
			else
			{
			$con="$con"."$rand_number";}
		}
		return $con;
	}

	public function purchase_delete($purchase_id = null)
	{
			//Delete product_purchase table
		$this->db->where('purchase_id',$purchase_id);
		$this->db->delete('product_purchase'); 
		//Delete product_purchase_details table
		$this->db->where('purchase_id',$purchase_id);
		$this->db->delete('product_purchase_details');
		return true;
		if ($this->db->affected_rows()) {
			return true;
		} else {
			return false;
		}
}
//purchase list date to date
	public function purchase_list_date_to_date($start,$end)
	{
		$this->db->select('a.*,b.manufacturer_name');
		$this->db->from('product_purchase a');
		$this->db->join('manufacturer_information b','b.manufacturer_id = a.manufacturer_id');
		$this->db->order_by('a.purchase_date','desc');
     	$this->db->where('a.purchase_date >=', $start);
        $this->db->where('a.purchase_date <=', $end);
		$query = $this->db->get();
		
		$last_query =  $this->db->last_query();
		if ($query->num_rows() > 0) {
			return $query->result_array();
		}
		return false;
	}
	
	public function purchasedatabyid($purchase_id){
        $this->db->select('a.*,b.manufacturer_name');
		$this->db->from('product_purchase a');
		$this->db->join('manufacturer_information b','b.manufacturer_id = a.manufacturer_id','left');
		$this->db->where('a.purchase_id',$purchase_id);
		$query = $this->db->get();
		if ($query->num_rows() > 0) {
			return $query->result_array();	
		}
		return false;
	}
	//purchase details by id
	public function purchase_detailsbyid($purchase_id){
		$this->db->select('a.*,b.*');
		$this->db->from('product_purchase_details a');//
		$this->db->join('product_information b','b.product_id = a.product_id','left');
		$this->db->where('a.purchase_id',$purchase_id);
		
		$query = $this->db->get();
		if ($query->num_rows() > 0) {
			return $query->result_array();	
		}
		return false;
	
	}

	/**
	 * Bandingkan harga satuan tiap obat pada satu nota dengan harga
	 * pembelian TERAKHIR SEBELUMNYA untuk obat + distributor yang sama.
	 *
	 * Mengembalikan array dengan key product_id:
	 *   status      => 'naik' | 'turun' | 'sama' | 'baru'
	 *   rate        => harga saat ini
	 *   prev_rate   => harga sebelumnya (null bila belum pernah beli)
	 *   selisih     => rate - prev_rate
	 *
	 * @param  string $purchase_id
	 * @return array
	 */
	public function purchase_price_status($purchase_id)
	{
		// Data nota yang sedang dilihat: distributor & tanggalnya.
		$current = $this->db->select('a.manufacturer_id, a.purchase_date')
		                    ->from('product_purchase a')
		                    ->where('a.purchase_id', $purchase_id)
		                    ->get()->row();

		if (empty($current)) {
			return array();
		}

		$items = $this->db->select('product_id, rate')
		                  ->from('product_purchase_details')
		                  ->where('purchase_id', $purchase_id)
		                  ->get()->result();

		$result = array();

		foreach ($items as $item) {
			// Harga terakhir sebelum nota ini, untuk obat + distributor yang sama.
			$prev = $this->db->select('d.rate')
			                 ->from('product_purchase_details d')
			                 ->join('product_purchase p', 'p.purchase_id = d.purchase_id')
			                 ->where('d.product_id', $item->product_id)
			                 ->where('p.manufacturer_id', $current->manufacturer_id)
			                 ->where('d.purchase_id !=', $purchase_id)
			                 ->where('p.purchase_date <=', $current->purchase_date)
			                 ->order_by('p.purchase_date', 'desc')
			                 ->order_by('d.id', 'desc')
			                 ->limit(1)
			                 ->get()->row();

			$rate      = (float) $item->rate;
			$prev_rate = (!empty($prev) ? (float) $prev->rate : null);

			if ($prev_rate === null) {
				$status = 'baru';
			} elseif ($rate > $prev_rate) {
				$status = 'naik';
			} elseif ($rate < $prev_rate) {
				$status = 'turun';
			} else {
				$status = 'sama';
			}

			$result[$item->product_id] = array(
				'status'    => $status,
				'rate'      => $rate,
				'prev_rate' => $prev_rate,
				'selisih'   => ($prev_rate === null ? 0 : $rate - $prev_rate),
			);
		}

		return $result;
	}

	/**
	 * Ringkasan status harga satu nota: berapa obat yang naik/turun/sama/baru.
	 *
	 * @param  string $purchase_id
	 * @return array
	 */
	public function purchase_price_status_summary($purchase_id)
	{
		$detail  = $this->purchase_price_status($purchase_id);
		$summary = array('naik' => 0, 'turun' => 0, 'sama' => 0, 'baru' => 0);

		foreach ($detail as $row) {
			$summary[$row['status']]++;
		}

		return $summary;
	}

	/**
	 * Versi massal dari purchase_price_status_summary() untuk daftar nota.
	 *
	 * Dipakai di halaman manage_purchase yang bisa menampilkan ratusan nota
	 * sekaligus. Memakai 1 query untuk seluruh nota, bukan 1 query per obat,
	 * supaya halaman tidak berat.
	 *
	 * @param  array $purchase_ids
	 * @return array  key = purchase_id, value = array ringkasan
	 */
	public function purchase_price_status_bulk($purchase_ids = array())
	{
		$summary = array();

		if (empty($purchase_ids)) {
			return $summary;
		}

		foreach ($purchase_ids as $pid) {
			$summary[$pid] = array('naik' => 0, 'turun' => 0, 'sama' => 0, 'baru' => 0);
		}

		// Ambil seluruh baris pembelian milik nota-nota terkait beserta
		// distributor & tanggalnya, lalu bandingkan di PHP.
		$this->db->select('d.purchase_id, d.product_id, d.rate, d.id,
		                   p.manufacturer_id, p.purchase_date');
		$this->db->from('product_purchase_details d');
		$this->db->join('product_purchase p', 'p.purchase_id = d.purchase_id');
		$this->db->where_in('d.purchase_id', $purchase_ids);
		$target = $this->db->get()->result();

		if (empty($target)) {
			return $summary;
		}

		// Kumpulkan obat + distributor yang perlu dicari riwayatnya.
		$product_ids      = array();
		$manufacturer_ids = array();
		foreach ($target as $t) {
			$product_ids[$t->product_id]           = true;
			$manufacturer_ids[$t->manufacturer_id] = true;
		}

		// Seluruh riwayat harga obat+distributor tersebut, diurutkan menaik.
		$this->db->select('d.product_id, d.rate, d.id,
		                   p.manufacturer_id, p.purchase_date, d.purchase_id');
		$this->db->from('product_purchase_details d');
		$this->db->join('product_purchase p', 'p.purchase_id = d.purchase_id');
		$this->db->where_in('d.product_id', array_keys($product_ids));
		$this->db->where_in('p.manufacturer_id', array_keys($manufacturer_ids));
		$this->db->order_by('p.purchase_date', 'asc');
		$this->db->order_by('d.id', 'asc');
		$history_rows = $this->db->get()->result();

		// Kelompokkan riwayat per obat+distributor.
		$history = array();
		foreach ($history_rows as $h) {
			$history[$h->product_id.'|'.$h->manufacturer_id][] = $h;
		}

		foreach ($target as $t) {
			$key       = $t->product_id.'|'.$t->manufacturer_id;
			$prev_rate = null;

			if (isset($history[$key])) {
				foreach ($history[$key] as $h) {
					// Berhenti begitu sampai ke baris nota ini sendiri.
					if ($h->purchase_id == $t->purchase_id && $h->id == $t->id) {
						break;
					}
					if ($h->purchase_date > $t->purchase_date) {
						break;
					}
					$prev_rate = (float) $h->rate;
				}
			}

			$rate = (float) $t->rate;

			if ($prev_rate === null) {
				$summary[$t->purchase_id]['baru']++;
			} elseif ($rate > $prev_rate) {
				$summary[$t->purchase_id]['naik']++;
			} elseif ($rate < $prev_rate) {
				$summary[$t->purchase_id]['turun']++;
			} else {
				$summary[$t->purchase_id]['sama']++;
			}
		}

		return $summary;
	}

	// manufacturer info
	public function manufacturer_info($id){
        $this->db->select('*');
		$this->db->from('manufacturer_information');
		$this->db->where('manufacturer_id',$id);
		$query = $this->db->get();
		if ($query->num_rows() > 0) {
			return $query->result_array();	
		}
		return false;
	}
	
}