<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Cpurchase extends CI_Controller {
	
	function __construct() {
      	parent::__construct();
    }

	public function index()
	{	
		$CI =& get_instance();
		$CI->auth->check_admin_auth();
		$CI->load->library('lpurchase');
		$content = $CI->lpurchase->purchase_add_form();
		$this->template->full_admin_html_view($content);
	}

	//Manage purchase
	    public function manage_purchase() {
        $this->load->library('lpurchase');
        $content = $this->lpurchase->purchase_list();
        $this->template->full_admin_html_view($content);
    }

        public function CheckPurchaseList(){
        // GET data
        $this->load->model('Purchases');
        $postData = $this->input->post();
        $data = $this->Purchases->getPurchaseList($postData);
        echo json_encode($data);
    }

        /**
         * Tandai satu nota "Due Payment" sudah dibayar ke distributor.
         *
         * Dipanggil lewat AJAX dari tombol "Tandai Lunas" pada halaman
         * Kelola Pembelian. Menjawab JSON supaya tabel bisa dimuat ulang
         * tanpa berpindah halaman.
         */
        public function purchase_mark_paid(){
        $this->auth->check_admin_auth();
        $this->load->model('Purchases');
        header('Content-Type: application/json');

        // Hak akses sama dengan mengubah pembelian: menandai lunas
        // mengubah data nota, bukan sekadar membacanya.
        if(!$this->permission1->method('manage_purchase','update')->access()){
            echo json_encode(array('success'=>FALSE,'message'=>'Anda tidak berhak mengubah data pembelian.'));
            return;
        }

        $purchase_id = $this->input->post('purchase_id',true);
        $paid_date   = $this->input->post('paid_date',true);
        $paid_note   = $this->input->post('paid_note',true);

        if(empty($purchase_id)){
            echo json_encode(array('success'=>FALSE,'message'=>'Nota pembelian tidak dipilih.'));
            return;
        }

        echo json_encode($this->Purchases->purchase_mark_paid($purchase_id, $paid_date, $paid_note));
    }

        // Isi dropdown filter (faktur & nama barang) pada Kelola Pembelian.
        public function purchase_filter_options(){
        $this->auth->check_admin_auth();
        $this->load->model('Purchases');
        header('Content-Type: application/json');
        echo json_encode($this->Purchases->getPurchaseFilterOptions());
    }
//purchase list by invoice no
    public function purchase_info_id(){
        $CI =& get_instance();
		$this->auth->check_admin_auth();
		$CI->load->library('lpurchase');
		$CI->load->model('Purchases');
	    $invoice_no = $this->input->post('invoice_no',true);
	    $content = $this->lpurchase->purchase_list_invoice_no($invoice_no);
	   	$this->template->full_admin_html_view($content);
	}
	//Insert purchase
	public function insert_purchase()
	{
		$CI =& get_instance();
		$CI->auth->check_admin_auth();
		$CI->load->model('Purchases');
	   $purchase_id = $CI->Purchases->purchase_entry();
	   $this->session->set_userdata(array('message'=>display('successfully_added')));
		redirect("Cpurchase/invoice_html/".$purchase_id);
	
	}

	//purchase Update Form
	public function purchase_update_form($purchase_id)
	{	
		$CI =& get_instance();
		$CI->auth->check_admin_auth();
		$CI->load->library('lpurchase');
		$content = $CI->lpurchase->purchase_edit_data($purchase_id);
		$this->template->full_admin_html_view($content);
	}

	// purchase Update
	public function purchase_update()
	{
		$CI =& get_instance();
		$CI->auth->check_admin_auth();
		$CI->load->model('Purchases');
     	$purchase_id = $CI->Purchases->update_purchase();
		$this->session->set_userdata(array('message'=>display('successfully_updated')));
		redirect("Cpurchase/invoice_html/".$purchase_id);
	}

	
	//Purchase item by search
	public function purchase_item_by_search()
	{
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		$CI->load->library('lpurchase');
		$manufacturer_id = $this->input->post('manufacturer_id',true);			
        $content = $CI->lpurchase->purchase_by_search($manufacturer_id);
		$this->template->full_admin_html_view($content);
	}
	
	//Product search by manufacturer id
public function product_search_by_manufacturer(){
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		$CI->load->library('lpurchase');
		$CI->load->model('Manufacturers');
		$product_name 	= $this->input->post('product_name',true);
		// Search all medicines, not limited to the selected manufacturer
        $product_info 	= $CI->Manufacturers->product_search_item(null,$product_name);
       if(!empty($product_info)){
		$list[''] = '';
		foreach ($product_info as $value) {
			$json_product[] = array('label'=>medicine_name($value['product_name'],$value['strength']),'value'=>$value['product_id']);
		} 
	}else{
		$json_product[] = 'No Medicine Found';
		}
        echo json_encode($json_product);
	
	}

	//Retrive right now inserted data to cretae html
	public function purchase_details_data($purchase_id){	
		$CI =& get_instance();
		$CI->auth->check_admin_auth();
		$CI->load->library('lpurchase');
		$content = $CI->lpurchase->purchase_details_data($purchase_id);	
		$this->template->full_admin_html_view($content);
	}

	public function delete_purchase($purchase_id = null){ 
          $this->load->model('Purchases');
        if ($this->Purchases->purchase_delete($purchase_id)) {
            #set success message
            $this->session->set_flashdata('message',display('delete_successfully'));
        } else {
            #set exception message
            $this->session->set_flashdata('error_message',display('please_try_again'));

        }
        redirect(base_url('Cpurchase/manage_purchase'));
    }
    // purchase info date to date
    public function manage_purchase_date_to_date()
	{
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		$CI->load->library('lpurchase');
		$CI->load->model('Purchases');
        $start=  $this->input->post('from_date',true);
        $end=  $this->input->post('to_date',true);

        $content =$this->lpurchase->purchase_list_date_to_date($start,$end);
		$this->template->full_admin_html_view($content);
	}
	// search batch id 
	public function batch_search_by_product(){

		$CI =& get_instance();
		$this->auth->check_admin_auth();
		$CI->load->library('lpurchase');
		$CI->load->model('Products');
		$product_id = $this->input->post('product_id',true);	
		
        $content = $CI->Products->batch_search_item($product_id);

        if (empty($content)) {
        	echo "No Product Found !";
	    }else{
	    	// Select option created for product
	        echo "<select name=\"batch_id[]\"   class=\"batch_id_1 form-control\" id=\"batch_id_1\">";
	        	echo "<option value=\"0\">".display('select_one')."</option>";
	        	foreach ($content as $product) {
	    			echo "<option value=".$product['batch_id'].">";
	    			echo $product['batch_id'];
	    			echo "</option>"; 
	        	}	
	        echo "</select>";
	    }
	}
    /**
     * Unduh template CSV pembelian.
     *
     * Dibuat langsung dari kode (bukan file statis) supaya judul kolomnya
     * selalu sama dengan yang dibaca uploadCsv_Purchase().
     */
    public function download_csv_template_purchase()
    {
        $this->auth->check_admin_auth();

        $header = array(
            'manufacturer_name',
            'purchase_date',
            'chalan_no',
            'details',
            'product_name',
            'batch_id',
            'expiry_date',
            'qty',
            'price',
            'discount',
            'payment_type',
        );

        // Dua baris contoh memakai data yang benar-benar ada di database
        // supaya template langsung bisa dicoba unggah. Bila database masih
        // kosong, isian contoh diberi tanda agar jelas harus diganti.
        $manufacturer = $this->db->select('manufacturer_name')
                                 ->from('manufacturer_information')
                                 ->where('status', 1)
                                 ->limit(1)->get()->row();
        $products = $this->db->select('product_name')
                             ->from('product_information')
                             ->where('status', 1)
                             ->limit(2)->get()->result();

        $nama_distributor = (!empty($manufacturer) ? $manufacturer->manufacturer_name : 'NAMA DISTRIBUTOR');
        $barang1 = (isset($products[0]) ? $products[0]->product_name : 'NAMA BARANG 1');
        $barang2 = (isset($products[1]) ? $products[1]->product_name : 'NAMA BARANG 2');

        // Dua baris di bawah memakai chalan_no yang sama, jadi keduanya
        // masuk sebagai satu pembelian dengan dua barang.
        $chalan = 'PO-'.date('Ymd').'-01';
        $rows = array(
            array($nama_distributor, date('Y-m-d'), $chalan, 'Contoh pembelian', $barang1, 'BATCH-001', date('Y-m-d', strtotime('+1 year')), 10, 5000, 0, 1),
            array($nama_distributor, date('Y-m-d'), $chalan, 'Contoh pembelian', $barang2, 'BATCH-002', date('Y-m-d', strtotime('+2 year')), 5, 12000, 0, 1),
        );

        // Baris petunjuk di bagian bawah berkas. Diawali '#' supaya mudah
        // dikenali sebagai catatan dan tinggal dihapus sebelum diunggah;
        // importer juga akan menolaknya bila lupa terhapus.
        $catatan = array(
            array('# PETUNJUK PENGISIAN - hapus seluruh baris yang diawali # sebelum mengunggah'),
            array('# manufacturer_name = nama distributor, harus sudah terdaftar dan ditulis persis sama'),
            array('# purchase_date     = tanggal pembelian, format YYYY-MM-DD'),
            array('# chalan_no         = NOMOR FAKTUR DARI DISTRIBUTOR, yaitu nomor pada faktur/surat'),
            array('#                     jalan fisik yang Anda terima. Contoh: INV/KF/2026/00123'),
            array('#                     Sama dengan isian "Nomor Faktur" pada form pembelian manual.'),
            array('#                     Tidak boleh sama dengan pembelian sebelumnya dari distributor'),
            array('#                     yang sama, jadi TIDAK BISA diisi nilai tetap. Distributor'),
            array('#                     berbeda boleh memakai nomor yang sama.'),
            array('#                     Baris dengan nomor faktur + distributor sama akan digabung'),
            array('#                     menjadi satu pembelian.'),
            array('# details           = keterangan pembelian, boleh dikosongkan'),
            array('# product_name      = nama barang, harus sudah terdaftar dan ditulis persis sama'),
            array('# batch_id          = nomor batch barang'),
            array('# expiry_date       = tanggal kedaluwarsa, format YYYY-MM-DD'),
            array('# qty               = jumlah barang, angka lebih dari 0'),
            array('# price             = harga beli per satuan, tanpa pemisah ribuan'),
            array('# discount          = diskon per barang dalam PERSEN, kosong dianggap 0'),
            array('# payment_type      = 1 = Tunai, 2 = Transfer, kosong dianggap 1'),
        );

        $filename = 'template_pembelian_'.date('Ymd').'.csv';
        header('Content-Type: text/csv; charset=UTF-8');
        header('Content-Disposition: attachment; filename="'.$filename.'"');
        header('Pragma: no-cache');
        header('Expires: 0');

        $out = fopen('php://output', 'w');
        // BOM UTF-8 supaya Excel membaca huruf beraksen dengan benar.
        fwrite($out, "\xEF\xBB\xBF");
        fputcsv($out, $header);
        foreach ($rows as $row) {
            fputcsv($out, $row);
        }
        // Petunjuk ditaruh paling bawah agar tidak mengganggu baris data.
        fputcsv($out, array(''));
        foreach ($catatan as $row) {
            fputcsv($out, $row);
        }
        fclose($out);
        exit;
    }

    /**
     * Unggah pembelian massal dari file CSV.
     *
     * Satu baris CSV = satu barang. Baris-baris dengan chalan_no dan
     * distributor yang sama digabung menjadi satu pembelian. Seluruh berkas
     * diperiksa lebih dulu; bila ada satu baris yang salah, tidak ada data
     * yang disimpan (dibungkus transaksi) supaya data tidak masuk separuh.
     */
    function uploadCsv_Purchase()
    {
        $this->auth->check_admin_auth();

        // --- 1. Periksa berkas unggahan -------------------------------
        if (empty($_FILES['upload_csv_file']['name']) || !is_uploaded_file($_FILES['upload_csv_file']['tmp_name'])) {
            $this->session->set_userdata(array('error_message' => 'File CSV belum dipilih.'));
            redirect(base_url('Cpurchase'));
            return;
        }
        if ($_FILES['upload_csv_file']['error'] !== UPLOAD_ERR_OK) {
            $this->session->set_userdata(array('error_message' => 'File gagal diunggah (kode '.$_FILES['upload_csv_file']['error'].').'));
            redirect(base_url('Cpurchase'));
            return;
        }
        $ext = strtolower(pathinfo($_FILES['upload_csv_file']['name'], PATHINFO_EXTENSION));
        if ($ext !== 'csv' && $ext !== 'txt') {
            $this->session->set_userdata(array('error_message' => 'Format file harus .csv'));
            redirect(base_url('Cpurchase'));
            return;
        }

        $fp = fopen($_FILES['upload_csv_file']['tmp_name'], 'r');
        if ($fp === FALSE) {
            $this->session->set_userdata(array('error_message' => 'File CSV tidak dapat dibaca.'));
            redirect(base_url('Cpurchase'));
            return;
        }

        // --- 2. Baca & validasi seluruh baris -------------------------
        $errors  = array();
        $baris   = array();
        $lineNo  = 0;
        $first   = TRUE;

        while (($csv_line = fgetcsv($fp, 4096)) !== FALSE) {
            $lineNo++;

            // Lewati baris judul dan baris kosong.
            if ($first) {
                $first = FALSE;
                // Buang BOM UTF-8 bila ada agar judul kolom terbaca.
                if (isset($csv_line[0])) {
                    $csv_line[0] = preg_replace('/^\xEF\xBB\xBF/', '', $csv_line[0]);
                }
                if (isset($csv_line[0]) && strtolower(trim($csv_line[0])) === 'manufacturer_name') {
                    continue;
                }
            }
            if ($csv_line === array(NULL) || count(array_filter($csv_line, 'strlen')) === 0) {
                continue;
            }
            // Baris petunjuk pada template diawali '#'. Dilewati supaya berkas
            // tetap bisa diunggah walau catatannya lupa dihapus.
            if (isset($csv_line[0]) && substr(ltrim($csv_line[0]), 0, 1) === '#') {
                continue;
            }

            $r = array(
                'manufacturer_name' => isset($csv_line[0]) ? trim($csv_line[0]) : '',
                'purchase_date'     => isset($csv_line[1]) ? trim($csv_line[1]) : '',
                'chalan_no'         => isset($csv_line[2]) ? trim($csv_line[2]) : '',
                'details'           => isset($csv_line[3]) ? trim($csv_line[3]) : '',
                'product_name'      => isset($csv_line[4]) ? trim($csv_line[4]) : '',
                'batch_id'          => isset($csv_line[5]) ? trim($csv_line[5]) : '',
                'expiry_date'       => isset($csv_line[6]) ? trim($csv_line[6]) : '',
                'qty'               => isset($csv_line[7]) ? trim($csv_line[7]) : '',
                'price'             => isset($csv_line[8]) ? trim($csv_line[8]) : '',
                'discount'          => isset($csv_line[9]) ? trim($csv_line[9]) : 0,
                'payment_type'      => isset($csv_line[10]) ? trim($csv_line[10]) : 1,
            );

            // Distributor harus terdaftar.
            $manufacturer = $this->db->select('manufacturer_id')
                                     ->from('manufacturer_information')
                                     ->where('manufacturer_name', $r['manufacturer_name'])
                                     ->get()->row();
            if (empty($manufacturer)) {
                $errors[] = 'Baris '.$lineNo.': distributor "'.$r['manufacturer_name'].'" tidak ditemukan.';
                continue;
            }
            $r['manufacturer_id'] = $manufacturer->manufacturer_id;

            // Barang harus terdaftar.
            $product = $this->db->select('product_id')
                                ->from('product_information')
                                ->where('product_name', $r['product_name'])
                                ->get()->row();
            if (empty($product)) {
                $errors[] = 'Baris '.$lineNo.': barang "'.$r['product_name'].'" tidak ditemukan.';
                continue;
            }
            $r['product_id'] = $product->product_id;

            if ($r['chalan_no'] === '') {
                $errors[] = 'Baris '.$lineNo.': chalan_no (no. faktur pembelian) wajib diisi.';
                continue;
            }
            if ($r['batch_id'] === '') {
                $errors[] = 'Baris '.$lineNo.': batch_id wajib diisi.';
                continue;
            }
            if (!is_numeric($r['qty']) || (float)$r['qty'] <= 0) {
                $errors[] = 'Baris '.$lineNo.': qty harus angka lebih dari 0.';
                continue;
            }
            if (!is_numeric($r['price']) || (float)$r['price'] < 0) {
                $errors[] = 'Baris '.$lineNo.': price harus angka.';
                continue;
            }
            if (!is_numeric($r['discount'])) {
                $r['discount'] = 0;
            }

            $tgl_beli = strtotime($r['purchase_date']);
            if ($tgl_beli === FALSE) {
                $errors[] = 'Baris '.$lineNo.': purchase_date "'.$r['purchase_date'].'" tidak dikenali.';
                continue;
            }
            $r['purchase_date'] = date('Y-m-d', $tgl_beli);

            $tgl_exp = strtotime($r['expiry_date']);
            if ($tgl_exp === FALSE) {
                $errors[] = 'Baris '.$lineNo.': expiry_date "'.$r['expiry_date'].'" tidak dikenali.';
                continue;
            }
            $r['expiry_date'] = date('Y-m-d', $tgl_exp);

            // payment_type: 1 = tunai, selain itu mengikuti master payment_type.
            $r['payment_type'] = (is_numeric($r['payment_type']) ? (int)$r['payment_type'] : 1);

            $baris[] = $r;
        }
        fclose($fp);

        if (empty($baris) && empty($errors)) {
            $this->session->set_userdata(array('error_message' => 'File CSV tidak berisi data.'));
            redirect(base_url('Cpurchase'));
            return;
        }
        // Bila ada baris bermasalah, tidak ada yang disimpan sama sekali.
        if (!empty($errors)) {
            $tampil = array_slice($errors, 0, 10);
            $pesan  = 'Impor dibatalkan, tidak ada data yang disimpan.<br>'.implode('<br>', $tampil);
            if (count($errors) > count($tampil)) {
                $pesan .= '<br>... dan '.(count($errors) - count($tampil)).' kesalahan lain.';
            }
            $this->session->set_userdata(array('error_message' => $pesan));
            redirect(base_url('Cpurchase'));
            return;
        }

        // --- 3. Kelompokkan per (distributor + chalan_no) -------------
        $group = array();
        foreach ($baris as $r) {
            $key = $r['manufacturer_id'].'|'.$r['chalan_no'];
            if (!isset($group[$key])) {
                $group[$key] = array('head' => $r, 'items' => array());
            }
            $group[$key]['items'][] = $r;
        }

        // Chalan_no yang sudah dipakai ditolak, mengikuti aturan input manual.
        foreach ($group as $key => $g) {
            $ada = $this->db->select('purchase_id')
                            ->from('product_purchase')
                            ->where('chalan_no', $g['head']['chalan_no'])
                            ->where('manufacturer_id', $g['head']['manufacturer_id'])
                            ->where('status', 1)
                            ->get()->num_rows();
            if ($ada > 0) {
                $errors[] = 'No. faktur "'.$g['head']['chalan_no'].'" sudah pernah dipakai untuk distributor tersebut.';
            }
        }
        if (!empty($errors)) {
            $this->session->set_userdata(array('error_message' => 'Impor dibatalkan.<br>'.implode('<br>', $errors)));
            redirect(base_url('Cpurchase'));
            return;
        }

        // --- 4. Simpan (semua atau tidak sama sekali) -----------------
        $jml_pembelian = 0;
        $jml_barang    = 0;
        $urut          = 0;  // nomor urut untuk menyusun purchase_id

        $this->db->trans_begin();
        foreach ($group as $g) {
            $head = $g['head'];
            // purchase_id harus unik. date('YmdHis') + nomor urut saja belum
            // cukup: dua unggahan pada detik yang sama memulai nomor urut dari
            // 0 lagi sehingga bisa bentrok dan menggabungkan dua pembelian
            // yang tidak berhubungan. Karena itu id dicek ke database dan
            // digeser sampai benar-benar belum terpakai.
            do {
                $purchase_id = date('YmdHis').sprintf('%03d', $urut);
                $urut++;
                $bentrok = $this->db->select('purchase_id')
                                    ->from('product_purchase')
                                    ->where('purchase_id', $purchase_id)
                                    ->get()->num_rows();
            } while ($bentrok > 0);

            $grand_total = 0;
            foreach ($g['items'] as $it) {
                $sub = (float)$it['qty'] * (float)$it['price'];
                $grand_total += $sub - ($sub * (float)$it['discount'] / 100);
            }

            $this->db->insert('product_purchase', array(
                'purchase_id'        => $purchase_id,
                'chalan_no'          => $head['chalan_no'],
                'manufacturer_id'    => $head['manufacturer_id'],
                'grand_total_amount' => $grand_total,
                'total_discount'     => 0,
                'purchase_date'      => $head['purchase_date'],
                'purchase_details'   => $head['details'],
                'status'             => 1,
                'payment_type'       => $head['payment_type'],
            ));
            $jml_pembelian++;

            foreach ($g['items'] as $it) {
                $sub = (float)$it['qty'] * (float)$it['price'];
                $this->db->insert('product_purchase_details', array(
                    'purchase_detail_id' => $this->generator(15),
                    'purchase_id'        => $purchase_id,
                    'product_id'         => $it['product_id'],
                    'quantity'           => $it['qty'],
                    'rate'               => $it['price'],
                    'total_amount'       => $sub - ($sub * (float)$it['discount'] / 100),
                    'discount'           => $it['discount'],
                    'batch_id'           => $it['batch_id'],
                    'expeire_date'       => $it['expiry_date'],
                    'status'             => 1,
                ));
                $jml_barang++;
            }
        }

        if ($this->db->trans_status() === FALSE) {
            $this->db->trans_rollback();
            $this->session->set_userdata(array('error_message' => 'Gagal menyimpan data, seluruh perubahan dibatalkan.'));
            redirect(base_url('Cpurchase'));
            return;
        }

        $this->db->trans_commit();
        $this->session->set_userdata(array(
            'message' => 'Impor berhasil: '.$jml_pembelian.' pembelian, '.$jml_barang.' baris barang.'
        ));
        redirect(base_url('Cpurchase/manage_purchase'));
    }
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

public function invoice_html($purchase_id){
    $this->load->model('Purchases');
    $this->load->model('Web_settings');
    $data['title']           = display('purchase_detail');
    $currency_details        = $this->Web_settings->retrieve_setting_editdata();
    $data['purchase']        = $this->Purchases->purchasedatabyid($purchase_id);
    $data['details']         = $this->Purchases->purchase_detailsbyid($purchase_id);
    $data['manufacturer_info']  = $this->Purchases->manufacturer_info($data['purchase'][0]['manufacturer_id']);
    $data['company_info']    = $this->Purchases->retrieve_company();
    $data['currency']        = $currency_details[0]['currency'];
    $data['position']        = $currency_details[0]['currency_position'];
    // Status harga tiap obat dibanding pembelian sebelumnya
    // dari distributor yang sama.
    $data['price_status']    = $this->Purchases->purchase_price_status($purchase_id);
    $content = $this->parser->parse('purchase/purchase_html', $data, true);
    $this->template->full_admin_html_view($content);
  }

  /**
   * Unduh detail satu nota pembelian sebagai berkas Excel/CSV.
   *
   * Nilai angka ditulis mentah (tanpa pemisah ribuan maupun simbol mata
   * uang) supaya di Excel langsung terbaca sebagai angka dan bisa dijumlah.
   */
  public function invoice_excel($purchase_id = null)
  {
    $this->auth->check_admin_auth();
    $this->load->model('Purchases');

    if (empty($purchase_id)) {
      $this->session->set_userdata(array('error_message' => 'Nota pembelian tidak ditemukan.'));
      redirect(base_url('Cpurchase/manage_purchase'));
      return;
    }

    $purchase = $this->Purchases->purchasedatabyid($purchase_id);
    if (empty($purchase)) {
      $this->session->set_userdata(array('error_message' => 'Nota pembelian "'.$purchase_id.'" tidak ditemukan.'));
      redirect(base_url('Cpurchase/manage_purchase'));
      return;
    }

    $details      = $this->Purchases->purchase_detailsbyid($purchase_id);
    $price_status = $this->Purchases->purchase_price_status($purchase_id);
    $manufacturer = $this->Purchases->manufacturer_info($purchase[0]['manufacturer_id']);
    $company      = $this->Purchases->retrieve_company();

    // Nama berkas memakai no. faktur bila ada, supaya mudah dikenali.
    $label = ($purchase[0]['chalan_no'] != '' ? $purchase[0]['chalan_no'] : $purchase_id);
    $filename = 'detail_pembelian_'.preg_replace('/[^A-Za-z0-9_\-]/', '_', $label).'.csv';

    header('Content-Type: text/csv; charset=UTF-8');
    header('Content-Disposition: attachment; filename="'.$filename.'"');
    header('Pragma: no-cache');
    header('Expires: 0');

    $out = fopen('php://output', 'w');
    // BOM UTF-8 supaya Excel membaca huruf beraksen dengan benar.
    fwrite($out, "\xEF\xBB\xBF");

    // --- Kepala nota ------------------------------------------------
    if (!empty($company)) {
      fputcsv($out, array('Perusahaan', $company[0]['company_name']));
    }
    fputcsv($out, array('Nomor Faktur', $purchase[0]['chalan_no']));
    fputcsv($out, array('ID Pembelian', $purchase[0]['purchase_id']));
    fputcsv($out, array('Tanggal Pembelian', $purchase[0]['purchase_date']));
    if (!empty($manufacturer)) {
      fputcsv($out, array('Distributor', $manufacturer[0]['manufacturer_name']));
    }
    if ($purchase[0]['purchase_details'] != '') {
      fputcsv($out, array('Keterangan', $purchase[0]['purchase_details']));
    }
    fputcsv($out, array(''));

    // --- Rincian barang ---------------------------------------------
    fputcsv($out, array(
      'No', 'Nama Barang', 'Batch', 'Tanggal Kadaluwarsa',
      'Kuantitas', 'Harga Beli', 'Diskon (%)', 'Jumlah', 'Status Harga', 'Harga Sebelumnya',
    ));

    $sl        = 1;
    $sub_total = 0;
    $sub_qty   = 0;
    if (!empty($details)) {
      foreach ($details as $d) {
        // Barang retur tersimpan sebagai kuantitas negatif; ditulis apa
        // adanya agar penjumlahan di Excel tetap benar.
        $qty    = (float) $d['quantity'];
        $amount = (float) $d['total_amount'];

        $ps = (isset($price_status[$d['product_id']]) ? $price_status[$d['product_id']] : null);
        if (empty($ps) || $ps['status'] == 'baru') {
          $status_label = 'Baru';
          $prev_rate    = '';
        } else {
          $map = array('naik' => 'Naik', 'turun' => 'Turun', 'sama' => 'Sama');
          $status_label = (isset($map[$ps['status']]) ? $map[$ps['status']] : $ps['status']);
          $prev_rate    = (float) $ps['prev_rate'];
        }

        fputcsv($out, array(
          $sl,
          medicine_name($d['product_name'], $d['strength'], ' - '),
          ($d['batch_id'] != '' ? $d['batch_id'] : '-'),
          ($d['expeire_date'] != '' ? $d['expeire_date'] : '-'),
          $qty,
          (float) $d['rate'],
          (float) $d['discount'],
          $amount,
          $status_label,
          $prev_rate,
        ));

        $sub_total += $amount;
        $sub_qty   += $qty;
        $sl++;
      }
    }

    // --- Ringkasan ---------------------------------------------------
    fputcsv($out, array(''));
    fputcsv($out, array('', 'Subtotal', '', '', $sub_qty, '', '', $sub_total));

    if ($purchase[0]['total_discount'] != '' && (float) $purchase[0]['total_discount'] != 0) {
      fputcsv($out, array('', 'Total Diskon', '', '', '', '', '', (float) $purchase[0]['total_discount']));
    }

    // isset() dipakai supaya nota lama (tersimpan sebelum fitur diskon
    // keseluruhan & PPN ada) tetap bisa diunduh.
    $od_amount = (isset($purchase[0]['overall_discount_amount']) ? (float) $purchase[0]['overall_discount_amount'] : 0);
    if ($od_amount > 0) {
      fputcsv($out, array('', 'Diskon Keseluruhan', '', '', '', '', '', -$od_amount));
    }
    $ppn_amount = (isset($purchase[0]['ppn_amount']) ? (float) $purchase[0]['ppn_amount'] : 0);
    if ($ppn_amount > 0) {
      fputcsv($out, array('', 'PPN', '', '', '', '', '', $ppn_amount));
    }

    fputcsv($out, array('', 'Jumlah Total', '', '', '', '', '', (float) $purchase[0]['grand_total_amount']));

    fclose($out);
    exit;
  }
}