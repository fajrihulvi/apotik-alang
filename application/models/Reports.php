<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class reports extends CI_Model {
    public function __construct()
    {
        parent::__construct();
        $this->load->database();
    }
    //Count report
    public function count_stock_report()
    {
        $this->db->select("a.product_name,a.product_id,a.cartoon_quantity,a.price,a.product_model,sum(b.quantity) as 'totalSalesQnty',(select sum(product_purchase_details.quantity) from product_purchase_details where product_id= `a`.`product_id`) as 'totalBuyQnty'");
        $this->db->from('product_information a');
        $this->db->join('invoice_details b','b.product_id = a.product_id');
        $this->db->where(array('a.status'=>1,'b.status'=>1));
        $this->db->group_by('a.product_id');
        $query = $this->db->get();      
        return $query->num_rows();

    }
        //Out of stock
    public function out_of_stock(){

      $this->db->select("a.unit,a.product_name,a.product_id,a.price,a.product_model,(select sum(quantity) from invoice_details where product_id= `a`.`product_id`) as 'totalSalesQnty',(select sum(quantity) from product_purchase_details where product_id= `a`.`product_id`) as 'totalBuyQnty'");
        $this->db->from('product_information a');
        $this->db->where(array('a.status' => 1));
        $this->db->group_by('a.product_id');
        $query = $this->db->get();
         $result = $query->result_array();
         $stock = [];
         $i = 0;
         foreach ($result as $stockproduct) {
            $stokqty = $stockproduct['totalBuyQnty']-$stockproduct['totalSalesQnty'];
            if($stokqty < 10){

             $stock[$i]['stock']         = $stockproduct['totalBuyQnty']-$stockproduct['totalSalesQnty'];
             $stock[$i]['product_id']    = $stockproduct['product_id'];
             $stock[$i]['product_name']  = $stockproduct['product_name'];
             $stock[$i]['product_model'] = $stockproduct['product_model'];
             $stock[$i]['unit']          = $stockproduct['unit'];
         }
             $i++;
         }
        return $stock;
    }


    public function getStockOutList($postData=null){
         $response = array();
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
            $searchQuery = " (a.product_name like '%".$searchValue."%' or b.manufacturer_name like '%".$searchValue."%') ";
         }

         ## Total number of records without filtering
         $this->db->select("count(*) as allcount,((select ifnull(sum(quantity),0) from product_purchase_details where product_id= `a`.`product_id`)-(select ifnull(sum(quantity),0) from invoice_details where product_id= `a`.`product_id`)) as 'stock'");
         $this->db->from('product_information a');
         $this->db->join('manufacturer_information b','b.manufacturer_id=a.manufacturer_id','left');
          if($searchValue != ''){
         $this->db->where($searchQuery);
     }
         $this->db->having('stock < 10');
         $this->db->group_by('a.product_id');
         $totalRecords = $this->db->get()->num_rows();

         ## Total number of record with filtering
         $this->db->select("count(*) as allcount,((select ifnull(sum(quantity),0) from product_purchase_details where product_id= `a`.`product_id`)-(select ifnull(sum(quantity),0) from invoice_details where product_id= `a`.`product_id`)) as 'stock'");
         $this->db->from('product_information a');
          $this->db->join('manufacturer_information b','b.manufacturer_id=a.manufacturer_id','left');
         if($searchValue != ''){
         $this->db->where($searchQuery);
     }
         $this->db->having('stock < 10');
         $this->db->group_by('a.product_id');
         $totalRecordwithFilter = $this->db->get()->num_rows();

         ## Fetch records
         $this->db->select("b.manufacturer_name,a.product_name,a.generic_name,a.strength,((select ifnull(sum(quantity),0) from product_purchase_details where product_id= `a`.`product_id`)-(select ifnull(sum(quantity),0) from invoice_details where product_id= `a`.`product_id`)) as 'stock'");
         $this->db->from('product_information a');
          $this->db->join('manufacturer_information b','b.manufacturer_id=a.manufacturer_id','left');
         if($searchValue != ''){
         $this->db->where($searchQuery);
     }
         $this->db->having('stock < 10');
         $this->db->group_by('a.product_id');
         $this->db->order_by($columnName, $columnSortOrder);
         $this->db->limit($rowperpage, $start);
         $records = $this->db->get()->result();
         $data = array();
         $sl =1;
         foreach($records as $record ){
            $data[] = array( 
                'sl'               =>  $sl,
                'product_name'     =>  medicine_name($record->product_name,$record->strength),
                'manufacturer_name'=>  $record->manufacturer_name,
                'generic_name'     =>  $record->generic_name,
                'stock'            =>  $record->stock,
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

        public function stock_csv_file()
    {
        $this->db->select("a.product_id,
                a.product_name,
                a.product_model,
                 a.price,
                a.manufacturer_price
                ");
        $this->db->from('product_information a');
        $query = $this->db->get();
        $stok_report = $query->result_array();
        
         $i = 1;
        foreach($stok_report as $k=>$v){$i++;
                $stockin = $this->db->select('sum(quantity) as totalSalesQnty')->from('invoice_details')->where('product_id',$stok_report[$k]['product_id'])->get()->row();
                $stockout = $this->db->select('sum(quantity) as totalPurchaseQnty')->from('product_purchase_details')->where('product_id',$stok_report[$k]['product_id'])->get()->row();
                
             $stok_report[$k]['totalPurchaseQnty'] = $stockout->totalPurchaseQnty;  
              $stok_report[$k]['totalSalesQnty'] = $stockin->totalSalesQnty;
             $stok_report[$k]['stok_quantity_cartoon'] = ($stockout->totalPurchaseQnty-$stockin->totalSalesQnty);
              $stok_report[$k]['purchase_total']=$stok_report[$k]['stok_quantity_cartoon']*$stok_report[$k]['manufacturer_price'];
               
                  $stok_report[$k]['total_sale_price']=$stok_report[$k]['stok_quantity_cartoon']*$stok_report[$k]['price'];
                
             


            }
            return $stok_report;
        
    }   

        public function count_stock_report_bydate()
    {   
        $this->db->select("a.*,
                a.product_name,
                a.product_id,
                a.product_model,
                a.manufacturer_price
                ");
        $this->db->from('product_information a');
    
        
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->num_rows();  
        }
        return false;
    }




        public function getExpireList($postData=null){
         $date=date('Y-m-d');
         $response = array();
         
         ## Read value
         $draw = $postData['draw'];
         $start = $postData['start'];
         $rowperpage = $postData['length']; // Rows display per page
         $columnIndex = $postData['order'][0]['column']; // Column index
         $columnName = $postData['columns'][$columnIndex]['data']; // Column name
         $columnSortOrder = $postData['order'][0]['dir']; // asc or desc
         $searchValue = $postData['search']['value']; // Search value

         ## Search
         // Nama distributor ikut dicari supaya bisa menelusuri batch
         // berdasarkan pemasoknya.
         $searchQuery = "";
         if($searchValue != ''){
            $searchQuery = " (a.product_name like '%".$searchValue."%' or b.batch_id like '%".$searchValue."%' or b.expeire_date like'%".$searchValue."%' or m.manufacturer_name like '%".$searchValue."%') ";
         }

         // Distributor diambil dari nota pembelian batch tersebut, bukan dari
         // master barang, supaya menunjukkan pemasok yang sebenarnya.
         $joinDistributor = function(){
            $this->db->join('product_purchase pp','pp.purchase_id = b.purchase_id','left');
            $this->db->join('manufacturer_information m','m.manufacturer_id = pp.manufacturer_id','left');
         };

         ## Total number of records without filtering
         $this->db->select("count(*) as allcount,((select ifnull(sum(quantity),0) from product_purchase_details where product_id= `a`.`product_id`)-(select ifnull(sum(quantity),0) from invoice_details where product_id= `a`.`product_id`)) as 'stock'");
         $this->db->from('product_information a');
         $this->db->join('product_purchase_details b','b.product_id=a.product_id','left');
         $joinDistributor();
         $this->db->where('b.expeire_date <=', $date);
         $this->db->having('stock > 0');
         $this->db->group_by('b.batch_id');
         $this->db->group_by('a.product_id');
         $totalRecords = $this->db->get()->num_rows();

         ## Total number of record with filtering
         $this->db->select("count(*) as allcount,((select ifnull(sum(quantity),0) from product_purchase_details where product_id= `a`.`product_id`)-(select ifnull(sum(quantity),0) from invoice_details where product_id= `a`.`product_id`)) as 'stock'");
         $this->db->from('product_information a');
         $this->db->join('product_purchase_details b','b.product_id=a.product_id','left');
         $joinDistributor();
         if($searchValue != ''){
         $this->db->where($searchQuery);
     }
         $this->db->where('b.expeire_date <=', $date);
         $this->db->having('stock > 0');
         $this->db->group_by('b.batch_id');
         $this->db->group_by('a.product_id');
         $totalRecordwithFilter = $this->db->get()->num_rows();

         ## Fetch records
         $this->db->select("b.*,a.product_name,a.strength,m.manufacturer_name,((select ifnull(sum(quantity),0) from product_purchase_details where product_id= `a`.`product_id`)-(select ifnull(sum(quantity),0) from invoice_details where product_id= `a`.`product_id`)) as 'stock'");
         $this->db->from('product_information a');
         $this->db->join('product_purchase_details b','b.product_id=a.product_id','left');
         $joinDistributor();
         if($searchValue != ''){
         $this->db->where($searchQuery);
     }
         $this->db->where('b.expeire_date <=', $date);
         $this->db->having('stock > 0');
         $this->db->group_by('b.batch_id');
         $this->db->group_by('a.product_id');
         if($columnName == 'manufacturer_name'){
            $this->db->order_by('m.manufacturer_name', $columnSortOrder);
         } else {
            $this->db->order_by($columnName, $columnSortOrder);
         }
         $this->db->limit($rowperpage, $start);
         $records = $this->db->get()->result();
         $data = array();
         $sl =1;
        $base_url = base_url();
         foreach($records as $record ){
            $medicine_name = '<a href="'.$base_url.'Cproduct/product_details/'.$record->product_id.'" class="" data-toggle="tooltip" data-placement="left" >'.medicine_name($record->product_name,$record->strength).'</a>';
            $data[] = array(
                'sl'                =>  $sl,
                'product_id'        =>  $medicine_name,
                'manufacturer_name' =>  ($record->manufacturer_name != '' ? $record->manufacturer_name : '-'),
                'batch_id'          =>  $record->batch_id,
                'expeire_date'      =>  $record->expeire_date,
                'stock'             =>  $record->stock,
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


    //Out of stock count
    public function out_of_stock_count(){

    
  $this->db->select("b.manufacturer_name,a.product_name,a.generic_name,a.strength,((select ifnull(sum(quantity),0) from product_purchase_details where product_id= `a`.`product_id`)-(select ifnull(sum(quantity),0) from invoice_details where product_id= `a`.`product_id`)) as 'stock'");
       $this->db->from('product_information a');
       $this->db->join('manufacturer_information b','b.manufacturer_id=a.manufacturer_id','left');
         $this->db->having('stock < 10');
         $this->db->group_by('a.product_id');
         return $records = $this->db->get()->num_rows();


    }
    // out of date count
    public function out_of_date_count(){

          $date=date('Y-m-d');
         $this->db->select("b.*,a.product_name,a.strength,((select ifnull(sum(quantity),0) from product_purchase_details where product_id= `a`.`product_id`)-(select ifnull(sum(quantity),0) from invoice_details where product_id= `a`.`product_id`)) as 'stock'");
         $this->db->from('product_information a');
         $this->db->join('product_purchase_details b','b.product_id=a.product_id','left');
         $this->db->where('b.expeire_date <=', $date);
         $this->db->having('stock > 0');
         $this->db->group_by('b.batch_id');
         $this->db->group_by('a.product_id');
        return $records = $this->db->get()->num_rows();


    }

    // Ambil ambang notifikasi kedaluwarsa (bulan) dari web_setting. Default 8.
    private function expiry_alert_months(){
        $setting = $this->db->select('expiry_alert_months')->from('web_setting')->where('setting_id',1)->get()->row();
        $months = (!empty($setting) && (int)$setting->expiry_alert_months > 0) ? (int)$setting->expiry_alert_months : 8;
        return $months;
    }

    // Tingkat urgensi berjenjang berdasarkan sisa hari menuju kedaluwarsa.
    // Mengembalikan array [label_teks, kelas_css_bootstrap] untuk badge.
    private function expiry_urgency($days_left){
        if      ($days_left <= 1)  { return array('≤ 1 '.display('day'),    'label-danger');  }   // sangat kritis (merah)
        elseif  ($days_left <= 2)  { return array('≤ 2 '.display('days'),   'label-danger');  }
        elseif  ($days_left <= 3)  { return array('≤ 3 '.display('days'),   'label-danger');  }
        elseif  ($days_left <= 7)  { return array('≤ 1 '.display('week'),   'label-danger');  }   // 1 minggu (merah)
        elseif  ($days_left <= 10) { return array('≤ 10 '.display('days'),  'label-warning'); }   // oranye/kuning
        elseif  ($days_left <= 20) { return array('≤ 20 '.display('days'),  'label-warning'); }
        elseif  ($days_left <= 30) { return array('≤ 1 '.display('month'),  'label-info');    }   // 1 bulan (biru)
        else                       { return array('> 1 '.display('month'),  'label-default'); }   // jauh (abu)
    }

    // Jumlah obat MENDEKATI kedaluwarsa: expeire_date > hari ini DAN <= hari ini + N bulan, stok > 0.
    public function near_expiry_count(){
         $today  = date('Y-m-d');
         $months = $this->expiry_alert_months();
         $limitDate = date('Y-m-d', strtotime("+".$months." months"));
         $this->db->select("b.*,a.product_name,a.strength,((select ifnull(sum(quantity),0) from product_purchase_details where product_id= `a`.`product_id`)-(select ifnull(sum(quantity),0) from invoice_details where product_id= `a`.`product_id`)) as 'stock'");
         $this->db->from('product_information a');
         $this->db->join('product_purchase_details b','b.product_id=a.product_id','left');
         $this->db->where('b.expeire_date >', $today);
         $this->db->where('b.expeire_date <=', $limitDate);
         $this->db->having('stock > 0');
         $this->db->group_by('b.batch_id');
         $this->db->group_by('a.product_id');
         return $this->db->get()->num_rows();
    }

    // Daftar obat MENDEKATI kedaluwarsa (server-side DataTables). Meniru getExpireList.
    public function getNearExpiryList($postData=null){
         $today  = date('Y-m-d');
         $months = $this->expiry_alert_months();
         $limitDate = date('Y-m-d', strtotime("+".$months." months"));
         $response = array();

         ## Read value
         $draw = $postData['draw'];
         $start = $postData['start'];
         $rowperpage = $postData['length'];
         $columnIndex = $postData['order'][0]['column'];
         $columnName = $postData['columns'][$columnIndex]['data'];
         $columnSortOrder = $postData['order'][0]['dir'];
         $searchValue = $postData['search']['value'];

         ## Search
         // Nama distributor ikut dicari supaya bisa menelusuri batch
         // berdasarkan pemasoknya.
         $searchQuery = "";
         if($searchValue != ''){
            $searchQuery = " (a.product_name like '%".$searchValue."%' or b.batch_id like '%".$searchValue."%' or b.expeire_date like'%".$searchValue."%' or m.manufacturer_name like '%".$searchValue."%') ";
         }

         // Distributor diambil dari nota pembelian batch tersebut, bukan dari
         // master barang, supaya menunjukkan pemasok yang sebenarnya.
         $joinDistributor = function(){
            $this->db->join('product_purchase pp','pp.purchase_id = b.purchase_id','left');
            $this->db->join('manufacturer_information m','m.manufacturer_id = pp.manufacturer_id','left');
         };

         ## Total tanpa filtering
         $this->db->select("count(*) as allcount,((select ifnull(sum(quantity),0) from product_purchase_details where product_id= `a`.`product_id`)-(select ifnull(sum(quantity),0) from invoice_details where product_id= `a`.`product_id`)) as 'stock'");
         $this->db->from('product_information a');
         $this->db->join('product_purchase_details b','b.product_id=a.product_id','left');
         $joinDistributor();
         $this->db->where('b.expeire_date >', $today);
         $this->db->where('b.expeire_date <=', $limitDate);
         $this->db->having('stock > 0');
         $this->db->group_by('b.batch_id');
         $this->db->group_by('a.product_id');
         $totalRecords = $this->db->get()->num_rows();

         ## Total dengan filtering
         $this->db->select("count(*) as allcount,((select ifnull(sum(quantity),0) from product_purchase_details where product_id= `a`.`product_id`)-(select ifnull(sum(quantity),0) from invoice_details where product_id= `a`.`product_id`)) as 'stock'");
         $this->db->from('product_information a');
         $this->db->join('product_purchase_details b','b.product_id=a.product_id','left');
         $joinDistributor();
         if($searchValue != ''){ $this->db->where($searchQuery); }
         $this->db->where('b.expeire_date >', $today);
         $this->db->where('b.expeire_date <=', $limitDate);
         $this->db->having('stock > 0');
         $this->db->group_by('b.batch_id');
         $this->db->group_by('a.product_id');
         $totalRecordwithFilter = $this->db->get()->num_rows();

         ## Fetch records
         $this->db->select("b.*,a.product_name,a.strength,m.manufacturer_name,((select ifnull(sum(quantity),0) from product_purchase_details where product_id= `a`.`product_id`)-(select ifnull(sum(quantity),0) from invoice_details where product_id= `a`.`product_id`)) as 'stock'");
         $this->db->from('product_information a');
         $this->db->join('product_purchase_details b','b.product_id=a.product_id','left');
         $joinDistributor();
         if($searchValue != ''){ $this->db->where($searchQuery); }
         $this->db->where('b.expeire_date >', $today);
         $this->db->where('b.expeire_date <=', $limitDate);
         $this->db->having('stock > 0');
         $this->db->group_by('b.batch_id');
         $this->db->group_by('a.product_id');
         // Default: urutkan dari paling mendesak (expeire_date paling dekat). DataTables
         // tetap bisa override lewat sort kolom; jika sort default (kolom 0/sl), pakai tanggal.
         if($columnName == 'sl' || $columnName == 'urgency' || $columnName == 'days_left'){
            $this->db->order_by('b.expeire_date', 'asc');
         } elseif($columnName == 'manufacturer_name'){
            $this->db->order_by('m.manufacturer_name', $columnSortOrder);
         } else {
            $this->db->order_by($columnName, $columnSortOrder);
         }
         if($rowperpage > 0){ $this->db->limit($rowperpage, $start); }
         $records = $this->db->get()->result();

         $data = array();
         $sl = 1;
         $base_url = base_url();
         $today_ts = strtotime(date('Y-m-d'));
         foreach($records as $record ){
            $medicine_name = '<a href="'.$base_url.'Cproduct/product_details/'.$record->product_id.'" data-toggle="tooltip" data-placement="left">'.$record->product_name.'('.$record->strength.')</a>';
            // sisa hari menuju kedaluwarsa
            $days_left = (int) floor((strtotime($record->expeire_date) - $today_ts) / 86400);
            list($urg_label, $urg_class) = $this->expiry_urgency($days_left);
            $urgency_badge = '<span class="label '.$urg_class.'">'.$urg_label.'</span>';
            $days_text = $days_left.' '.display('days');
            $data[] = array(
                'sl'                => $sl,
                'product_id'        => $medicine_name,
                'manufacturer_name' => ($record->manufacturer_name != '' ? $record->manufacturer_name : '-'),
                'batch_id'          => $record->batch_id,
                'expeire_date'      => $record->expeire_date,
                'days_left'         => $days_text,
                'urgency'           => $urgency_badge,
                'stock'             => $record->stock,
            );
            $sl++;
         }

         $response = array(
            "draw" => intval($draw),
            "iTotalRecords" => $totalRecordwithFilter,
            "iTotalDisplayRecords" => $totalRecords,
            "aaData" => $data
         );
         return $response;
    }
    //Retrieve Single Item Stock Stock Report
    public function stock_report($limit,$page)
    {
    
        $this->db->select("a.product_name,a.product_id,a.cartoon_quantity,a.price,a.product_model,sum(b.quantity) as 'totalSalesQnty',(select sum(product_purchase_details.quantity) from product_purchase_details where product_id= `a`.`product_id`) as 'totalBuyQnty'");
        $this->db->from('product_information a');
        $this->db->join('invoice_details b','b.product_id = a.product_id');
        $this->db->where(array('a.status'=>1,'b.status'=>1));
        $this->db->group_by('a.product_id');
        $this->db->order_by('a.product_id','desc');
        $this->db->limit($limit, $page);
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }
    //Retrieve Single Item Stock Stock Report
    public function stock_report_single_item($product_id){
        $this->db->select("a.product_name,a.cartoon_quantity,a.price,a.product_model,sum(b.quantity) as 'totalSalesQnty',sum(c.quantity) as 'totalBuyQnty'");
        $this->db->from('product_information a');
        $this->db->join('invoice_details b','b.product_id = a.product_id');
        $this->db->join('product_purchase_details c','c.product_id = a.product_id');
        $this->db->where(array('a.product_id'=>$product_id,'a.status'=>1,'b.status'=>1));
        $this->db->group_by('a.product_id');
        $this->db->order_by('a.product_id','desc');
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }

    //Stock Report by date
public function stock_report_bydate($product_id,$date,$limit,$page)
    {   
        $this->db->select("a.*,
                a.product_name,
                a.product_id,
                a.product_model,
                a.manufacturer_price
                ");
        $this->db->from('product_information a');
    
        if(empty($product_id))
        {
            $this->db->where(array('a.status'=>1));
        }
        else
        {
            //Single product information 
            $this->db->where(array('a.status'=>1,'a.product_id'=>$product_id)); 
        }
        

        $this->db->limit($limit, $page);
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }
    public function totalnumberof_product(){

        $this->db->select("a.*,
                a.product_name,
                a.product_id,
                a.product_model,
                a.manufacturer_price
                ");
        $this->db->from('product_information a');

        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->num_rows();  
        }
        return false;

    }


    public function getCheckList($postData=null){

         $response = array();

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
            $searchQuery = " (a.product_name like '%".$searchValue."%' or a.product_model like '%".$searchValue."%' or a.price like'%".$searchValue."%' or a.manufacturer_price like'%".$searchValue."%' or m.manufacturer_name like'%".$searchValue."%') ";
         }

         // Filter dropdown multiple: beberapa barang / beberapa faktur pembelian.
         $filter_product  = $this->input->post('filter_product',true);
         $filter_purchase = $this->input->post('filter_purchase',true);
         $dropEmpty = function($val){
            if(!is_array($val)){ return array(); }
            return array_values(array_filter($val, function($v){
               return ($v !== null && $v !== '' && !is_array($v));
            }));
         };
         $filter_product  = $dropEmpty($filter_product);
         $filter_purchase = $dropEmpty($filter_purchase);

         // Faktur pembelian tidak ada di tabel product_information, jadi
         // disaring lewat daftar barang yang pernah dibeli pada faktur itu.
         //
         // Daftar id-nya diambil DI SINI, sebelum query utama mulai disusun:
         // memanggil get() di tengah penyusunan query akan mereset select/from/
         // join milik query utama (CI memanggil _reset_select() setiap get()).
         $produk_dari_faktur = null;   // null = filter faktur tidak dipakai
         if(!empty($filter_purchase)){
            $produk_dari_faktur = array();
            $this->db->distinct();
            $this->db->select('product_id');
            $this->db->from('product_purchase_details');
            $this->db->where_in('purchase_id', $filter_purchase);
            foreach($this->db->get()->result() as $r){
               $produk_dari_faktur[] = $r->product_id;
            }
            // Bila faktur terpilih tidak punya barang, hasilnya harus kosong.
            if(empty($produk_dari_faktur)){
               $produk_dari_faktur = array('');
            }
         }

         // Bagian WHERE dipakai ulang oleh query hitung dan query ambil data.
         $applyFilter = function() use ($searchValue, $searchQuery, $filter_product, $produk_dari_faktur){
            if($searchValue != ''){
               $this->db->where($searchQuery);
            }
            if(!empty($filter_product)){
               $this->db->where_in('a.product_id', $filter_product);
            }
            if($produk_dari_faktur !== null){
               $this->db->where_in('a.product_id', $produk_dari_faktur);
            }
         };

         ## Total number of records without filtering
         $this->db->select('count(*) as allcount');
         $this->db->from('product_information a');
         $this->db->join('manufacturer_information m','m.manufacturer_id = a.manufacturer_id','left');
         $records = $this->db->get()->result();
         $totalRecords = $records[0]->allcount;

         ## Total number of record with filtering
         $this->db->select('count(*) as allcount');
         $this->db->from('product_information a');
         $this->db->join('manufacturer_information m','m.manufacturer_id = a.manufacturer_id','left');
         $applyFilter();
         $records = $this->db->get()->result();
         $totalRecordwithFilter = $records[0]->allcount;

         // Stok dihitung di SQL (barang masuk - barang keluar), bukan lagi
         // lewat dua query tambahan per baris. Dengan begitu:
         //   1. kolom Stok bisa diurutkan di server, sebab ORDER BY butuh
         //      nilainya sudah ada saat query jalan;
         //   2. satu halaman cukup satu query, tidak lagi 2xN query.
         // Rumusnya sama persis dengan perhitungan lama, jadi angka yang
         // tampil tidak berubah.
         $stock_expression = "(COALESCE((SELECT SUM(pd.quantity) FROM product_purchase_details pd WHERE pd.product_id = a.product_id), 0)
                             - COALESCE((SELECT SUM(idt.quantity) FROM invoice_details idt WHERE idt.product_id = a.product_id), 0))";

         // Hanya kolom yang benar-benar ada yang boleh dipakai untuk ORDER BY,
         // supaya nama kolom dari sisi klien tidak bisa menyusup ke SQL.
         $sortable = array(
            'product_name'      => 'a.product_name',
            'sales_price'       => 'a.price',
            'purchase_p'        => 'a.manufacturer_price',
            'manufacturer_name' => 'm.manufacturer_name',
            'stok_quantity'     => $stock_expression,
         );
         $orderColumn = (isset($sortable[$columnName]) ? $sortable[$columnName] : 'a.product_name');
         $orderDir    = (strtolower($columnSortOrder) === 'desc' ? 'DESC' : 'ASC');

         ## Fetch records
         $this->db->select("a.*,
                a.product_name,
                a.product_id,
                a.product_model,
                a.manufacturer_price,
                m.manufacturer_name,
                {$stock_expression} AS stok_quantity
                ", FALSE);
         $this->db->from('product_information a');
         $this->db->join('manufacturer_information m','m.manufacturer_id = a.manufacturer_id','left');
         $applyFilter();
         $this->db->order_by($orderColumn.' '.$orderDir, '', FALSE);
         $this->db->limit($rowperpage, $start);
         $records = $this->db->get()->result();
         $data = array();
         $sl = $start + 1;
         $base_url = base_url();
         foreach($records as $record ){
             $medicine_name = '<a href="'.$base_url.'Cproduct/product_details/'.$record->product_id.'" class="" data-toggle="tooltip" data-placement="left" >'.medicine_name($record->product_name,$record->strength).'</a>';

            $data[] = array(
                'sl'            =>   $sl,
                'product_name'  =>  $medicine_name,
                'sales_price'   =>  $record->price,
                'purchase_p'    =>  $record->manufacturer_price,
                'stok_quantity' =>  $record->stok_quantity,
                'manufacturer_name'=> $record->manufacturer_name,
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
    //Stock report manufacturer by date
    public function stock_report_manufacturer_bydate($product_id=null,$manufacturer_id=null,$date=null,$perpage=null,$page=null){

        $this->db->select("*");
        $this->db->from('product_information ');
        $this->db->limit($perpage,$page);
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }
// manufacturer stock report id wise
    public function stock_report_manufacturer_byid($manufacturer_id=null,$date=null,$perpage=null,$page=null){

        $this->db->select("*");
        $this->db->from('product_information');
        $this->db->where('manufacturer_id',$manufacturer_id);
        
        $this->db->limit($perpage,$page);
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }
    //Counter of unique product histor which has been affected
    public function product_counter_by_manufacturer($manufacturer_id)
    {       
        $this->db->select('DISTINCT(a.product_id)');  
        $this->db->from('product_information a');
            if(!empty($manufacturer_id))
            {$this->db->where('a.manufacturer_id =',$manufacturer_id);  }
        $query=$this->db->get(); 
        return $query->num_rows();
    }



    //Counter of unique product histor which has been affected
    public function product_counter($product_id)
    {       
        $this->db->select('DISTINCT(product_id)');  
        $this->db->from('product_information');
            if(!empty($product_id))
            {$this->db->where('product_id =',$product_id);  }
        $query=$this->db->get(); 
        return $query->num_rows();
    }

    //Retrieve todays_total_sales_report
    public function todays_total_sales_report()
    {
        $today = date('Y-m-d');
        $this->db->select('sum(total_amount) as total_sale');
        $this->db->from('invoice');
        $this->db->where('date',$today);
        $this->db->group_by('date');
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;


    }
    // total purchase info
        public function todays_total_purchase()
    {
        $today = date('Y-m-d');
        $this->db->select('sum(grand_total_amount) as total_purchase');
        $this->db->from('product_purchase');
        $this->db->where('purchase_date',$today);
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }       

    // todays sales product
    public function todays_sale_product(){
        $today = date('Y-m-d');
        $this->db->select("c.product_name,c.price");
        $this->db->from('invoice a');
        $this->db->join('invoice_details b','b.invoice_id = a.invoice_id');
        $this->db->join('product_information c','c.product_id = b.product_id');
        $this->db->order_by('a.date','desc');
        $this->db->where('a.date',$today);
        $this->db->limit('3');
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }
    
    /**
     * Nama jenis pembayaran untuk satu baris laporan.
     *
     * Penjualan memakai master `payment_type`, jadi nama diambil dari sana.
     * Data lama yang id-nya belum ada di master tetap dinamai seperti pada
     * modul faktur (1 = Cash Payment, selain itu Bank Payment).
     *
     * @param array $row Baris hasil query, boleh punya payment_type_name
     * @return string
     */
    public function payment_type_label($row)
    {
        if (!empty($row['payment_type_name'])) {
            return $row['payment_type_name'];
        }
        if (!isset($row['payment_type']) || $row['payment_type'] === '' || $row['payment_type'] === null) {
            return '-';
        }
        return ($row['payment_type'] == 1 ? 'Cash Payment' : 'Bank Payment');
    }

    /**
     * Nama jenis pembayaran pembelian. Modul pembelian memakai pilihan tetap
     * 1/2/3, bukan master payment_type.
     *
     * @param array $row
     * @return string
     */
    public function purchase_payment_type_label($row)
    {
        if (!isset($row['payment_type']) || $row['payment_type'] === '' || $row['payment_type'] === null) {
            return '-';
        }
        switch ((int) $row['payment_type']) {
            case 1: return 'Cash Payment';
            case 2: return 'Bank Payment';
            case 3: return 'Due';
        }
        return '-';
    }

    //Retrieve todays_sales_report
    public function todays_sales_report($per_page,$page)
    {
        $today = date('Y-m-d');
        $this->db->select("a.*,b.customer_id,b.customer_name,pt.payment_type_name");
        $this->db->from('invoice a');
        $this->db->join('customer_information b','b.customer_id = a.customer_id');
        $this->db->join('payment_type pt','pt.id = a.payment_type','left');
        $this->db->where('a.date',$today);
        $this->db->limit($per_page,$page);
        $this->db->order_by('a.invoice_id','desc');
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }   

    //Retrieve todays_sales_report_count
    public function todays_sales_report_count()
    {
        $today = date('Y-m-d');
        $this->db->select("a.*,b.customer_id,b.customer_name");
        $this->db->from('invoice a');
        $this->db->join('customer_information b','b.customer_id = a.customer_id');
        $this->db->where('a.date',$today);
        $this->db->order_by('a.invoice_id','desc');
        $query = $this->db->get();  
        return $query->num_rows();
    }   

    //Retrieve todays_purchase_report
    public function todays_purchase_report($per_page=null,$page=null)
    {
        $today = date('Y-m-d');
        $this->db->select("a.*,b.manufacturer_id,b.manufacturer_name");
        $this->db->from('product_purchase a');
        $this->db->join('manufacturer_information b','b.manufacturer_id = a.manufacturer_id');
        $this->db->where('a.purchase_date',$today);
        $this->db->order_by('a.purchase_id','desc');
        $this->db->limit($per_page,$page);
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }

    //Retrieve todays_purchase_report count
    public function todays_purchase_report_count()
    {
        $today = date('Y-m-d');
        $this->db->select("a.*,b.manufacturer_id,b.manufacturer_name");
        $this->db->from('product_purchase a');
        $this->db->join('manufacturer_information b','b.manufacturer_id = a.manufacturer_id');
        $this->db->where('a.purchase_date',$today);
        $this->db->order_by('a.purchase_id','desc');
        $this->db->limit('500');
        $query = $this->db->get();  
        return $query->num_rows();
    }

    //Total profit report
    public function total_profit_report($perpage,$page){

        $this->db->select("a.date,a.invoice,b.invoice_id,
            CAST(sum(total_price) AS DECIMAL(16,2)) as total_sale");
        $this->db->select('CAST(sum(`quantity`*`manufacturer_rate`) AS DECIMAL(16,2)) as total_manufacturer_rate', FALSE);
        $this->db->select("CAST(SUM(total_price) - SUM(`quantity`*`manufacturer_rate`) AS DECIMAL(16,2)) AS total_profit");
        $this->db->from('invoice a');
        $this->db->join('invoice_details b','b.invoice_id = a.invoice_id');
        $this->db->group_by('b.invoice_id');
        $this->db->order_by('a.invoice','desc');
        $this->db->limit($perpage,$page);
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }
    //Total profit report
    public function total_profit_report_count(){

        $this->db->select("a.date,a.invoice,b.invoice_id,sum(total_price) as total_sale");
        $this->db->select('sum(`quantity`*`manufacturer_rate`) as total_manufacturer_rate', FALSE);
        $this->db->select("(SUM(total_price) - SUM(`quantity`*`manufacturer_rate`)) AS total_profit");
        $this->db->from('invoice a');
        $this->db->join('invoice_details b','b.invoice_id = a.invoice_id');
        $this->db->group_by('b.invoice_id');
        $this->db->order_by('a.invoice','desc');
        $query = $this->db->get();
        return $query->num_rows();
    }




    //Retrieve all Report
    public function retrieve_dateWise_SalesReports($start_date,$end_date)
    {
        $dateRange = "a.date BETWEEN '$start_date%' AND '$end_date%'";

        $this->db->select("a.*,b.customer_id,b.customer_name,pt.payment_type_name");
        $this->db->from('invoice a');
        $this->db->join('customer_information b','b.customer_id = a.customer_id');
        $this->db->join('payment_type pt','pt.id = a.payment_type','left');
        $this->db->where($dateRange, NULL, FALSE);
        $this->db->order_by('a.date','desc');
        $this->db->limit('500');
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }
    //Retrieve all Report
    public function retrieve_dateWise_PurchaseReports($start_date,$end_date)
    {
        $dateRange = "a.purchase_date BETWEEN '$start_date%' AND '$end_date%'";
        
        $this->db->select("a.*,b.manufacturer_id,b.manufacturer_name");
        $this->db->from('product_purchase a');
        $this->db->join('manufacturer_information b','b.manufacturer_id = a.manufacturer_id');
        $this->db->where($dateRange, NULL, FALSE);  
        $this->db->order_by('a.purchase_date','desc');
        $this->db->limit('500');
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }
    //Retrieve date wise profit report
    public function retrieve_dateWise_profit_report($start_date,$end_date,$per_page,$page)
    {
        $this->db->select("a.date,a.invoice,b.invoice_id,
            CAST(sum(total_price) AS DECIMAL(16,2)) as total_sale");
        $this->db->select('CAST(sum(`quantity`*`manufacturer_rate`) AS DECIMAL(16,2)) as total_manufacturer_rate', FALSE);
        $this->db->select("CAST(SUM(total_price) - SUM(`quantity`*`manufacturer_rate`) AS DECIMAL(16,2)) AS total_profit");

        $this->db->from('invoice a');
        $this->db->join('invoice_details b','b.invoice_id = a.invoice_id');
        $this->db->where('a.date >=', $start_date); 
        $this->db->where('a.date <=', $end_date); 

        $this->db->group_by('b.invoice_id');
        $this->db->order_by('a.invoice','desc');
        $this->db->limit($per_page,$page);
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }   
    //Retrieve date wise profit report
    public function retrieve_dateWise_profit_report_count($start_date,$end_date)
    {
        
        $this->db->select("a.date,a.invoice,b.invoice_id,sum(total_price) as total_sale");
        $this->db->select('sum(`quantity`*`manufacturer_rate`) as total_manufacturer_rate', FALSE);
        $this->db->select("(SUM(total_price) - SUM(`quantity`*`manufacturer_rate`)) AS total_profit");

        $this->db->from('invoice a');
        $this->db->join('invoice_details b','b.invoice_id = a.invoice_id');
        $this->db->where('a.date >=', $start_date); 
        $this->db->where('a.date <=', $end_date); 

        $this->db->group_by('b.invoice_id');
        $this->db->order_by('a.invoice','desc');
        $query = $this->db->get();
        return $query->num_rows();
    }
    //Product wise sales report
    public function product_wise_report()
    {
        $today = date('Y-m-d');
        $this->db->select("a.*,b.customer_id,b.customer_name");
        $this->db->from('invoice a');
        $this->db->join('customer_information b','b.customer_id = a.customer_id');
        $this->db->where('a.date',$today);
        $this->db->order_by('a.invoice_id','desc');
        $this->db->limit('500');
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }
    //RETRIEVE DATE WISE SINGE PRODUCT REPORT
    public function retrieve_product_sales_report($perpage,$page)
    {
        $this->db->select("a.*,b.product_name,b.product_model,c.date,c.total_amount,d.customer_name,c.payment_type,pt.payment_type_name");
        $this->db->from('invoice_details a');
        $this->db->join('product_information b','b.product_id = a.product_id');
        $this->db->join('invoice c','c.invoice_id = a.invoice_id');
        $this->db->join('customer_information d','d.customer_id = c.customer_id');
        $this->db->join('payment_type pt','pt.id = c.payment_type','left');
        $this->db->order_by('c.date','desc');
        $this->db->limit($perpage,$page);
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }   
    //RETRIEVE DATE WISE SINGE PRODUCT REPORT
    public function retrieve_product_sales_report_count()
    {
        $this->db->select("a.*,b.product_name,b.product_model,c.date,c.total_amount,d.customer_name");
        $this->db->from('invoice_details a');
        $this->db->join('product_information b','b.product_id = a.product_id');
        $this->db->join('invoice c','c.invoice_id = a.invoice_id');
        $this->db->join('customer_information d','d.customer_id = c.customer_id');
        $this->db->order_by('c.date','desc');
        $query = $this->db->get();  
        return $query->num_rows();
    }
    //RETRIEVE DATE WISE SEARCH SINGLE PRODUCT REPORT
    public function retrieve_product_search_sales_report( $start_date,$end_date )
    {
        $dateRange = "c.date BETWEEN '$start_date%' AND '$end_date%'";
        $this->db->select("a.*,b.product_name,b.product_model,c.date,d.customer_name,c.payment_type,pt.payment_type_name");
        $this->db->from('invoice_details a');
        $this->db->join('product_information b','b.product_id = a.product_id');
        $this->db->join('invoice c','c.invoice_id = a.invoice_id');
        $this->db->join('customer_information d','d.customer_id = c.customer_id');
        $this->db->join('payment_type pt','pt.id = c.payment_type','left');
        $this->db->where($dateRange, NULL, FALSE);
        $this->db->order_by('c.date','desc');
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();
        }
        return false;
    }
    //RETRIEVE DATE WISE SEARCH SINGLE PRODUCT REPORT
    public function retrieve_product_search_sales_report_count( $start_date,$end_date )
    {
        $dateRange = "c.date BETWEEN '$start_date%' AND '$end_date%'";
        $this->db->select("a.*,b.product_name,b.product_model,c.date,d.customer_name");
        $this->db->from('invoice_details a');
        $this->db->join('product_information b','b.product_id = a.product_id');
        $this->db->join('invoice c','c.invoice_id = a.invoice_id');
        $this->db->join('customer_information d','d.customer_id = c.customer_id');
        $this->db->where($dateRange, NULL, FALSE); 
        $this->db->order_by('c.date','desc');
        $query = $this->db->get();  
        return $query->num_rows();
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
    //

    // stock report batch wise 

public function stock_report_batch_bydate($perpage,$page){

        
        $this->db->select("b.*,
                sum(b.sell) as 'totalSalesQnty',
                sum(b.Purchase) as 'totalPurchaseQnty',
                b.batch_id
                ");
        $this->db->from('view_k_stock_batch_qty b');
        $this->db->group_by('b.batch_id');
        $this->db->group_by('b.product_id');
        $this->db->limit($perpage,$page);
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }


    /**
     * Isi dropdown filter pada Laporan Stock dan Laporan Stock (Per Batch):
     * daftar nama barang dan daftar faktur pembelian.
     *
     * @param string $scope 'all'      => semua barang (Laporan Stock)
     *                      'purchased'=> hanya barang yang pernah dibeli
     *                                    (Laporan Stock per Batch)
     */
    public function getStockFilterOptions($scope = 'all')
    {
        $products = array();
        if ($scope === 'purchased') {
            // Laporan per batch hanya menampilkan barang yang ada di pembelian.
            $this->db->distinct();
            $this->db->select('p.product_id, p.product_name, p.strength');
            $this->db->from('product_purchase_details d');
            $this->db->join('product_information p', 'p.product_id = d.product_id');
            $this->db->order_by('p.product_name', 'asc');
        } else {
            $this->db->select('product_id, product_name, strength');
            $this->db->from('product_information');
            $this->db->order_by('product_name', 'asc');
        }
        foreach ($this->db->get()->result() as $row) {
            $products[] = array(
                'id'   => $row->product_id,
                'text' => medicine_name($row->product_name, $row->strength),
            );
        }

        // Daftar faktur pembelian diambil dari tabel rincian, bukan dari
        // product_purchase, supaya tetap muncul walau baris induknya belum ada
        // (mis. data stok awal yang diimpor hanya pada tabel rincian).
        $purchases = array();
        $this->db->distinct();
        $this->db->select('d.purchase_id, p.chalan_no, p.purchase_date, m.manufacturer_name', FALSE);
        $this->db->from('product_purchase_details d');
        $this->db->join('product_purchase p', 'p.purchase_id = d.purchase_id', 'left');
        $this->db->join('manufacturer_information m', 'm.manufacturer_id = p.manufacturer_id', 'left');
        $this->db->order_by('d.purchase_id', 'desc');
        foreach ($this->db->get()->result() as $row) {
            // Label memakai no. faktur bila ada; bila tidak, id pembeliannya.
            $label = ($row->chalan_no != '' ? $row->chalan_no : $row->purchase_id);
            if ($row->manufacturer_name != '') {
                $label .= ' - '.$row->manufacturer_name;
            }
            if ($row->purchase_date != '') {
                $label .= ' ('.$row->purchase_date.')';
            }
            $purchases[] = array('id' => $row->purchase_id, 'text' => $label);
        }

        return array(
            'products'  => $products,
            'purchases' => $purchases,
        );
    }

    public function getCheckBatchStock($postData=null){

         $response = array();

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
            $searchQuery = " (m.product_name like '%".$searchValue."%' or a.batch_id like '%".$searchValue."%' or a.expeire_date like'%".$searchValue."%') ";
         }

         // Filter dropdown multiple: beberapa barang / beberapa faktur pembelian.
         $filter_product  = $this->input->post('filter_product',true);
         $filter_purchase = $this->input->post('filter_purchase',true);
         $dropEmpty = function($val){
            if(!is_array($val)){ return array(); }
            return array_values(array_filter($val, function($v){
               return ($v !== null && $v !== '' && !is_array($v));
            }));
         };
         $filter_product  = $dropEmpty($filter_product);
         $filter_purchase = $dropEmpty($filter_purchase);

         // Bagian WHERE dipakai ulang oleh query hitung dan query ambil data.
         // Di laporan per batch, faktur pembelian ada langsung pada barisnya
         // sehingga bisa disaring tanpa subquery.
         $applyFilter = function() use ($searchValue, $searchQuery, $filter_product, $filter_purchase){
            if($searchValue != ''){
               $this->db->where($searchQuery);
            }
            if(!empty($filter_product)){
               $this->db->where_in('a.product_id', $filter_product);
            }
            if(!empty($filter_purchase)){
               $this->db->where_in('a.purchase_id', $filter_purchase);
            }
         };

         ## Total number of records without filtering
         $this->db->select('count(*) as allcount');
         $this->db->from('product_purchase_details a');
         $this->db->join('product_information m','m.product_id = a.product_id','left');
         $this->db->group_by('a.batch_id');
         $this->db->group_by('a.product_id');
         $totalRecords = $this->db->get()->num_rows();

         ## Total number of record with filtering
         $this->db->select('count(*) as allcount');
         $this->db->from('product_purchase_details a');
         $this->db->join('product_information m','m.product_id = a.product_id','left');
         $applyFilter();
         $this->db->group_by('a.batch_id');
         $this->db->group_by('a.product_id');
         $totalRecordwithFilter = $this->db->get()->num_rows();

         ## Fetch records
         $this->db->select("a.*,
                m.product_name,
                m.strength,
                ");
         $this->db->from('product_purchase_details a');
         $this->db->join('product_information m','m.product_id = a.product_id','left');
         $applyFilter();
         $this->db->group_by('a.batch_id');
         $this->db->group_by('a.product_id');
         $this->db->order_by($columnName, $columnSortOrder);
         $this->db->limit($rowperpage, $start);
         $records = $this->db->get()->result();
         $data = array();
         $sl =1;
         $base_url = base_url();
         foreach($records as $record ){
          $stockout = $this->db->select('sum(quantity) as totalSalesQnty')->from('invoice_details')->where('product_id',$record->product_id)->where('batch_id',$record->batch_id)->get()->row();
         $stockin = $this->db->select('sum(quantity) as totalPurchaseQnty')->from('product_purchase_details')->where('product_id',$record->product_id)->where('batch_id',$record->batch_id)->get()->row();
          $medicine_name = '<a href="'.$base_url.'Cproduct/product_details/'.$record->product_id.'" class="" data-toggle="tooltip" data-placement="left" >'.medicine_name($record->product_name,$record->strength).'</a>';
            
               
            $data[] = array( 
                'sl'               =>   $sl,
                'product_name'     =>  $medicine_name,
                'strength'         =>  $record->strength,
                'batch_id'         =>  $record->batch_id,
                'expeire_date'     =>  $record->expeire_date,
                'inqty'            =>  (!empty($stockin->totalPurchaseQnty)?$stockin->totalPurchaseQnty:0),
                'outqty'           =>  (!empty($stockout->totalSalesQnty)?$stockout->totalSalesQnty:0),
                'stock'            =>  (!empty($stockin->totalPurchaseQnty)?$stockin->totalPurchaseQnty:0)-(!empty($stockout->totalSalesQnty)?$stockout->totalSalesQnty:0),
                
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

    // count batch stock
     public function stock_report_batch_count(){

        $this->db->select("b.*,
                sum(b.sell) as 'totalSalesQnty',
                sum(b.Purchase) as 'totalPurchaseQnty',
                b.batch_id
                ");
        $this->db->from('view_k_stock_batch_qty b');
        $this->db->group_by('b.batch_id');
         $query = $this->db->get();     
        return $query->num_rows();
     }

    
    //profit report manufacturer wise purchse
     public function profit_report_manufacturer($manufacturer_id,$from_date,$to_date){
        $this->db->select("
                AVG(a.rate) as avg_r,
                sum(a.quantity) as quantity
                ");
        $this->db->from('product_purchase_details a');
        $this->db->join('product_information b','b.product_id = a.product_id');
        $this->db->join('product_purchase c','c.purchase_id = a.purchase_id');
        $this->db->where('b.manufacturer_id',$manufacturer_id);
        $this->db->where('c.purchase_date >=', $from_date); 
        $this->db->where('c.purchase_date <=', $to_date); 
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }

    //profit report manufacturer wise purchse
     public function profit_report_manufacturer_sale($manufacturer_id,$from_date,$to_date){
        $this->db->select("
                AVG(a.rate) as avg_r,
                sum(a.quantity) as quantity
                ");
        $this->db->from('invoice_details a');
        $this->db->join('product_information b','b.product_id = a.product_id');
        $this->db->join('invoice c','c.invoice_id = a.invoice_id');
        $this->db->where('b.manufacturer_id',$manufacturer_id);
        $this->db->where('c.date >=', $from_date); 
        $this->db->where('c.date <=', $to_date); 
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }

    //profit report manufacturer wise purchse
     public function profit_report_productwise($product_id,$from_date,$to_date){
        $this->db->select("
                AVG(a.rate) as avg_r,
                sum(a.quantity) as quantity
                ");
        $this->db->from('product_purchase_details a');
        $this->db->join('product_purchase c','c.purchase_id = a.purchase_id');
        $this->db->where('a.product_id',$product_id);
        $this->db->where('c.purchase_date >=', $from_date); 
        $this->db->where('c.purchase_date <=', $to_date); 
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }

    //profit report product wise purchse
     public function profit_report_product_salesss($product_id,$from_date,$to_date){
        $this->db->select("
                AVG(a.rate) as avg_r,
                sum(a.quantity) as quantity
                ");
        $this->db->from('invoice_details a');
        $this->db->join('invoice c','a.invoice_id = c.invoice_id');
        $this->db->where('a.product_id',$product_id);
        $this->db->where('c.date >=', $from_date); 
        $this->db->where('c.date <=', $to_date); 
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
    }
        // chart information invoice data
public function inv_jan(){
  $month=1;
  $year=date('Y');
  $this->db->select('SUM(total_amount) as invoice_amount');
  $this->db->from('invoice');
  $this->db->where(array('MONTH(date)='=>$month,'YEAR(date)='=>$year));
 $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->invoice_amount;  
        }
        return 0;

    }
    public function inv_feb(){
  $month=2;
  $year=date('Y');
  $this->db->select('SUM(total_amount) as invoice_amount');
  $this->db->from('invoice');
  $this->db->where(array('MONTH(date)='=>$month,'YEAR(date)='=>$year));
 $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->invoice_amount;  
        }
        return 0;

    }
    public function inv_mar(){
  $month=3;
  $year=date('Y');
  $this->db->select('SUM(total_amount) as invoice_amount');
  $this->db->from('invoice');
  $this->db->where(array('MONTH(date)='=>$month,'YEAR(date)='=>$year));
  $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->invoice_amount;  
        }
        return 0;

    }
 public function inv_apr(){
  $month=4;
  $year=date('Y');
  $this->db->select('SUM(total_amount) as invoice_amount');
  $this->db->from('invoice');
  $this->db->where(array('MONTH(date)='=>$month,'YEAR(date)='=>$year));
$query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->invoice_amount;  
        }
        return 0;

    }
 public function inv_may(){
  $month=5;
  $year=date('Y');
  $this->db->select('SUM(total_amount) as invoice_amount');
  $this->db->from('invoice');
  $this->db->where(array('MONTH(date)='=>$month,'YEAR(date)='=>$year));
  $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->invoice_amount;  
        }
        return 0;

    }
     public function inv_jun(){
  $month=6;
  $year=date('Y');
  $this->db->select('SUM(total_amount) as invoice_amount');
  $this->db->from('invoice');
  $this->db->where(array('MONTH(date)='=>$month,'YEAR(date)='=>$year));
$query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->invoice_amount;  
        }
        return 0;

    }
     public function inv_jul(){
  $month=7;
  $year=date('Y');
  $this->db->select('SUM(total_amount) as invoice_amount');
  $this->db->from('invoice');
  $this->db->where(array('MONTH(date)='=>$month,'YEAR(date)='=>$year));
$query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->invoice_amount;  
        }
        return 0;

    }
     public function inv_aug(){
  $month=8;
  $year=date('Y');
  $this->db->select('SUM(total_amount) as invoice_amount');
  $this->db->from('invoice');
  $this->db->where(array('MONTH(date)='=>$month,'YEAR(date)='=>$year));
  $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->invoice_amount;  
        }
        return 0;

    }
     public function inv_sep(){
  $month=9;
  $year=date('Y');
  $this->db->select('SUM(total_amount) as invoice_amount');
  $this->db->from('invoice');
  $this->db->where(array('MONTH(date)='=>$month,'YEAR(date)='=>$year));
 $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->invoice_amount;  
        }
        return 0;

    }
     public function inv_oct(){
  $month=10;
  $year=date('Y');
  $this->db->select('SUM(total_amount) as invoice_amount');
  $this->db->from('invoice');
  $this->db->where(array('MONTH(date)='=>$month,'YEAR(date)='=>$year));
  $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->invoice_amount;  
        }
        return 0;

    }
     public function inv_nov(){
  $month=11;
  $year=date('Y');
  $this->db->select('SUM(total_amount) as invoice_amount');
  $this->db->from('invoice');
  $this->db->where(array('MONTH(date)='=>$month,'YEAR(date)='=>$year));
  $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->invoice_amount;  
        }
        return 0;

    }
     public function inv_dec(){
  $month=12;
  $year=date('Y');
  $this->db->select('SUM(total_amount) as invoice_amount');
  $this->db->from('invoice');
  $this->db->where(array('MONTH(date)='=>$month,'YEAR(date)='=>$year));
  $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->invoice_amount;  
        }
        return 0;

    }
//purchase chart data
    public function pur_jan(){
  $month=1;
  $year=date('Y');
  $this->db->select('SUM(grand_total_amount) as purchase_amount');
  $this->db->from('product_purchase');
  $this->db->where(array('MONTH(purchase_date)='=>$month,'YEAR(purchase_date)='=>$year));
    $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->purchase_amount;  
        }
        return 0;

    }
    public function pur_feb(){
  $month=2;
  $year=date('Y');
  $this->db->select('SUM(grand_total_amount) as purchase_amount');
  $this->db->from('product_purchase');
  $this->db->where(array('MONTH(purchase_date)='=>$month,'YEAR(purchase_date)='=>$year));
 $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->purchase_amount;  
        }
        return 0;

    }
    public function pur_mar(){
  $month=3;
  $year=date('Y');
  $this->db->select('SUM(grand_total_amount) as purchase_amount');
  $this->db->from('product_purchase');
  $this->db->where(array('MONTH(purchase_date)='=>$month,'YEAR(purchase_date)='=>$year));
 $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->purchase_amount;  
        }
        return 0;

    }
 public function pur_apr(){
  $month=4;
  $year=date('Y');
  $this->db->select('SUM(grand_total_amount) as purchase_amount');
  $this->db->from('product_purchase');
  $this->db->where(array('MONTH(purchase_date)='=>$month,'YEAR(purchase_date)='=>$year));
 $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->purchase_amount;  
        }
        return 0;

    }
 public function pur_may(){
  $month=5;
  $year=date('Y');
  $this->db->select('SUM(grand_total_amount) as purchase_amount');
  $this->db->from('product_purchase');
  $this->db->where(array('MONTH(purchase_date)='=>$month,'YEAR(purchase_date)='=>$year));
  $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->purchase_amount;  
        }
        return 0;

    }
     public function pur_jun(){
  $month=6;
  $year=date('Y');
  $this->db->select('SUM(grand_total_amount) as purchase_amount');
  $this->db->from('product_purchase');
  $this->db->where(array('MONTH(purchase_date)='=>$month,'YEAR(purchase_date)='=>$year));
  $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->purchase_amount;  
        }
        return 0;

    }
     public function pur_jul(){
  $month=7;
  $year=date('Y');
  $this->db->select('SUM(grand_total_amount) as purchase_amount');
  $this->db->from('product_purchase');
  $this->db->where(array('MONTH(purchase_date)='=>$month,'YEAR(purchase_date)='=>$year));
  $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->purchase_amount;  
        }
        return 0;

    }
     public function pur_aug(){
  $month=8;
  $year=date('Y');
  $this->db->select('SUM(grand_total_amount) as purchase_amount');
  $this->db->from('product_purchase');
  $this->db->where(array('MONTH(purchase_date)='=>$month,'YEAR(purchase_date)='=>$year));
   $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->purchase_amount;  
        }
        return 0;

    }
     public function pur_sep(){
  $month=9;
  $year=date('Y');
  $this->db->select('SUM(grand_total_amount) as purchase_amount');
  $this->db->from('product_purchase');
  $this->db->where(array('MONTH(purchase_date)='=>$month,'YEAR(purchase_date)='=>$year));
  $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->purchase_amount;  
        }
        return 0;

    }
     public function pur_oct(){
  $month=10;
  $year=date('Y');
  $this->db->select('SUM(grand_total_amount) as purchase_amount');
  $this->db->from('product_purchase');
  $this->db->where(array('MONTH(purchase_date)='=>$month,'YEAR(purchase_date)='=>$year));
   $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->purchase_amount;  
        }
        return 0;
    }
     public function pur_nov(){
  $month=11;
  $year=date('Y');
  $this->db->select('SUM(grand_total_amount) as purchase_amount');
  $this->db->from('product_purchase');
  $this->db->where(array('MONTH(purchase_date)='=>$month,'YEAR(purchase_date)='=>$year));
   $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->purchase_amount;  
        }
        return 0;

    }
     public function pur_dec(){
  $month=12;
  $year=date('Y');
  $this->db->select('SUM(grand_total_amount) as purchase_amount');
  $this->db->from('product_purchase');
  $this->db->where(array('MONTH(purchase_date)='=>$month,'YEAR(purchase_date)='=>$year));
   $query = $this->db->get();
        if ($query->num_rows() > 0) {
             $result = $query->row();
             return $result->purchase_amount;  
        }
        return 0;

    }
    
    
    public function profitloss_days($from,$to){
        $from_date =  $from;
        $to_date  = $to;
        $date = date('Y-m-d');
        $this->db->select("*");
        $this->db->from('invoice');
        $this->db->where('date >=', $from_date); 
        $this->db->where('date <=', $to_date); 
        $this->db->group_by('invoice_id');
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return [];
    }
    
    public function datewisesale($date){
        
        $this->db->select("sum(total_amount) as total_sale");
        $this->db->from('invoice');
        $this->db->where('date', $date); 
        $query = $this->db->get();

        $amount =  $query->row()->total_sale;
        return (!empty($amount)?$amount:0);
    
}


    public function datewisepurchase($date){
        
        $this->db->select("sum(grand_total_amount) as total_purchase");
        $this->db->from('product_purchase');
        $this->db->where('purchase_date', $date); 
        $query = $this->db->get();
            $amount =  $query->row()->total_purchase;   
        return (!empty($amount)?$amount:0);
}


# =====================================================================
# LABA HARIAN / MINGGUAN / BULANAN (menu Invoice Wise)
#
# Dulu ketiga ringkasan di bawah menghitung modal dari kolom
# product_information.manufacturer_price, sehingga angkanya tidak
# pernah cocok dengan dashboard. Ada tiga sebab:
#
#   1. Sumber harga beli berbeda. Kolom manufacturer_price di
#      database ini hampir seluruhnya kosong, jadi modal terbaca jauh
#      lebih kecil dari yang sebenarnya. Dashboard memakai harga beli
#      per batch dari product_purchase_details, yang terisi lengkap.
#   2. Harga beli tidak dibedakan per batch. Satu obat bisa dibeli
#      dengan harga berbeda tiap kali kulakan; memakai satu harga
#      tunggal per produk membuat modal meleset.
#   3. Rentang "minggu ini" berbeda: dulu dihitung sejak Sabtu lalu,
#      sedangkan dashboard memakai Senin s/d Minggu.
#
# Sekarang ketiganya memakai dashboard_summary() - persis perhitungan
# yang dipakai dashboard - sehingga angkanya dijamin sama.
# =====================================================================

/**
 * Laba hari ini.
 *
 * @return array
 */
public function todaysprofit(){
    $today = date('Y-m-d');
    return $this->profit_summary_range($today, $today);
}

/**
 * Laba minggu berjalan (Senin s/d Minggu), mengikuti definisi minggu
 * yang dipakai dashboard.
 *
 * @return array
 */
public function weekly(){
    $today = date('Y-m-d');
    return $this->profit_summary_range(
        date('Y-m-d', strtotime('monday this week', strtotime($today))),
        date('Y-m-d', strtotime('sunday this week', strtotime($today)))
    );
}

/**
 * Laba bulan berjalan (tanggal 1 s/d akhir bulan), mengikuti dashboard.
 *
 * @return array
 */
public function monthly(){
    return $this->profit_summary_range(date('Y-m-01'), date('Y-m-t'));
}

/**
 * Bungkus dashboard_summary() ke bentuk yang dipakai tampilan laporan
 * ini, supaya sumber angkanya benar-benar satu.
 *
 * @param string $from_date Y-m-d
 * @param string $to_date   Y-m-d
 * @return array
 */
private function profit_summary_range($from_date, $to_date){
    $summary = $this->dashboard_summary($from_date, $to_date);

    return array(
        'sale_amount'        => $summary['total_sell'],
        'manufacture_amount' => $summary['total_cost'],
        'profit'             => $summary['gross_margin'],
    );
}

  /**
   * Harga beli (modal) satu faktur, memakai harga per batch seperti
   * dashboard - bukan lagi product_information.manufacturer_price.
   *
   * @param string $invoice_id
   * @return float
   */
  public function invoice_manufacturerprice($invoice_id){
        $cost = $this->dashboard_cost_expression();

        $sql = "SELECT COALESCE(SUM(d.quantity * {$cost}), 0) AS total_cost
                  FROM invoice_details d
                 WHERE d.invoice_id = ?";

        $row = $this->db->query($sql, array($invoice_id))->row_array();

        return (!empty($row['total_cost']) ? (float) $row['total_cost'] : 0);
  }

  /**
   * Rincian penjualan per tanggal per obat untuk laporan Obat Wise.
   *
   * Satu baris = satu tanggal untuk satu obat, lengkap dengan jumlah,
   * satuan, dan distributornya. Modal memakai harga beli per batch
   * (product_purchase_details.rate) seperti laporan lain, supaya
   * angkanya konsisten.
   *
   * @param string      $from_date  Y-m-d
   * @param string      $to_date    Y-m-d
   * @param string|null $product_id Kosong berarti semua obat
   * @return array
   */
  public function profit_productwise_datewise($from_date, $to_date, $product_id = null)
  {
        $cost = $this->dashboard_cost_expression();

        $sql = "SELECT i.date,
                       d.product_id,
                       COALESCE(pr.product_name, '-')          AS product_name,
                       COALESCE(pr.unit, '-')                  AS unit,
                       COALESCE(m.manufacturer_name, '-')      AS manufacturer_name,
                       COALESCE(SUM(d.quantity), 0)            AS total_qty,
                       COALESCE(SUM(d.total_price), 0)         AS total_sell,
                       COALESCE(SUM(d.quantity * {$cost}), 0)  AS total_cost
                  FROM invoice i
                  JOIN invoice_details d ON d.invoice_id = i.invoice_id
             LEFT JOIN product_information pr ON pr.product_id = d.product_id
             LEFT JOIN manufacturer_information m ON m.manufacturer_id = pr.manufacturer_id
                 WHERE i.date BETWEEN ? AND ?";

        $params = array($from_date, $to_date);

        if (!empty($product_id)) {
            $sql .= " AND d.product_id = ?";
            $params[] = $product_id;
        }

        $sql .= " GROUP BY i.date, d.product_id
                  ORDER BY i.date ASC, product_name ASC";

        $rows = $this->db->query($sql, $params)->result_array();

        foreach ($rows as $k => $row) {
            $rows[$k]['total_qty']    = (float) $row['total_qty'];
            $rows[$k]['total_sell']   = (float) $row['total_sell'];
            $rows[$k]['total_cost']   = (float) $row['total_cost'];
            $rows[$k]['gross_margin'] = (float) $row['total_sell'] - (float) $row['total_cost'];
        }

        return $rows;
  }

  /**
   * Rincian penjualan per tanggal per distributor untuk laporan
   * Distributor Wise.
   *
   * Satu baris = satu tanggal untuk satu distributor, berisi nilai jual,
   * nilai modal, dan selisihnya. Modal memakai harga beli per batch
   * (product_purchase_details.rate) - harga saat barang dibeli - sama
   * seperti dashboard dan laporan Invoice Wise, supaya angkanya
   * konsisten antar laporan.
   *
   * Distributor ditelusuri lewat product_information.manufacturer_id
   * milik tiap obat yang terjual.
   *
   * @param string      $from_date       Y-m-d
   * @param string      $to_date         Y-m-d
   * @param string|null $manufacturer_id Kosong berarti semua distributor
   * @return array
   */
  public function profit_manufacturer_datewise($from_date, $to_date, $manufacturer_id = null)
  {
        $cost = $this->dashboard_cost_expression();

        $sql = "SELECT i.date,
                       p.manufacturer_id,
                       COALESCE(m.manufacturer_name, '-')      AS manufacturer_name,
                       COALESCE(SUM(d.quantity), 0)            AS total_qty,
                       COALESCE(SUM(d.total_price), 0)         AS total_sell,
                       COALESCE(SUM(d.quantity * {$cost}), 0)  AS total_cost
                  FROM invoice i
                  JOIN invoice_details d ON d.invoice_id = i.invoice_id
             LEFT JOIN product_information p ON p.product_id = d.product_id
             LEFT JOIN manufacturer_information m ON m.manufacturer_id = p.manufacturer_id
                 WHERE i.date BETWEEN ? AND ?";

        $params = array($from_date, $to_date);

        if (!empty($manufacturer_id)) {
            $sql .= " AND p.manufacturer_id = ?";
            $params[] = $manufacturer_id;
        }

        $sql .= " GROUP BY i.date, p.manufacturer_id
                  ORDER BY i.date ASC, manufacturer_name ASC";

        $rows = $this->db->query($sql, $params)->result_array();

        foreach ($rows as $k => $row) {
            $rows[$k]['total_qty']    = (float) $row['total_qty'];
            $rows[$k]['total_sell']   = (float) $row['total_sell'];
            $rows[$k]['total_cost']   = (float) $row['total_cost'];
            $rows[$k]['gross_margin'] = (float) $row['total_sell'] - (float) $row['total_cost'];
        }

        return $rows;
  }

  /**
   * Modal dan nama distributor untuk semua faktur dalam satu rentang,
   * diambil sekali jalan.
   *
   * Tampilan Invoice Wise dulu memanggil invoice_manufacturerprice()
   * per baris, jadi satu halaman laporan bisa menembak puluhan query.
   * Di sini semuanya dihitung dalam satu query dan dikembalikan sebagai
   * peta invoice_id => array('cost' => ..., 'distributor' => ...).
   *
   * Satu faktur bisa memuat obat dari beberapa distributor, sehingga
   * namanya digabung dan dipisah koma, bukan diambil salah satu saja.
   *
   * @param string $from_date Y-m-d
   * @param string $to_date   Y-m-d
   * @return array
   */
  public function invoice_cost_distributor_map($from_date, $to_date)
  {
        $cost = $this->dashboard_cost_expression();

        $sql = "SELECT d.invoice_id,
                       COALESCE(SUM(d.quantity * {$cost}), 0) AS total_cost,
                       GROUP_CONCAT(DISTINCT m.manufacturer_name ORDER BY m.manufacturer_name SEPARATOR ', ') AS distributor
                  FROM invoice i
                  JOIN invoice_details d ON d.invoice_id = i.invoice_id
             LEFT JOIN product_information p ON p.product_id = d.product_id
             LEFT JOIN manufacturer_information m ON m.manufacturer_id = p.manufacturer_id
                 WHERE i.date BETWEEN ? AND ?
              GROUP BY d.invoice_id";

        $query = $this->db->query($sql, array($from_date, $to_date));

        $map = array();
        foreach ($query->result_array() as $row) {
            $map[$row['invoice_id']] = array(
                'cost'        => (float) $row['total_cost'],
                'distributor' => (!empty($row['distributor']) ? $row['distributor'] : '-'),
            );
        }

        return $map;
  }

  public function medicine_list(){
        $this->db->select("*");
        $this->db->from('product_information');
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            return $query->result_array();  
        }
        return false;
  }

      public function daily_closing_entry($data) {
        $this->db->insert('daily_closing', $data);
    }

    // This function will find out all closing information of daily closing.
    public function accounts_closing_data() {
        $last_closing_amount = $this->get_last_closing_amount();
        $cash_in = $this->cash_data_receipt();
        $cash_out = $this->cash_data();
        if ($last_closing_amount != null) {
            $last_closing_amount = $last_closing_amount[0]['amount'];
            $cash_in_hand = ($last_closing_amount+$cash_in) - $cash_out;
        } else {
            $last_closing_amount = 0;
            $cash_in_hand = $cash_in - $cash_out;
        }

        $company_info = $this->Reports->retrieve_company();
        return array(
            "last_day_closing" => number_format($last_closing_amount, 2, '.', ','),
            "cash_in"          => number_format($cash_in, 2, '.', ','),
            "cash_out"         => number_format($cash_out, 2, '.', ','),
            "company_info"     => $company_info,
            "cash_in_hand"     => number_format($cash_in_hand, 2, '.', ',')
        );
    }
        public function get_last_closing_amount() {
        $sql = "SELECT amount FROM daily_closing WHERE date = (SELECT MAX(date) FROM daily_closing)";
        $query = $this->db->query($sql);
        $result = $query->result_array();
        if ($result) {
            return $result;
        } else {
            return FALSE;
        }
    }
    
        public function cash_data_receipt() {
        //-----------
        $cash = 0;
        $datse = date('Y-m-d');
        $this->db->select('sum(Debit) as amount');
        $this->db->from('acc_transaction');
        $this->db->where('COAID', 1020101);
        $this->db->where('VDate', $datse);
        $result_amount = $this->db->get();
        $amount = $result_amount->result_array();
        $cash += $amount[0]['amount'];
        return $cash;
    }
        public function cash_data() {
        //-----------
        $cash = 0;
        $datse = date('Y-m-d');
        $this->db->select('sum(Credit) as amount');
        $this->db->from('acc_transaction');
        $this->db->where('COAID', 1020101);
        $this->db->where('VDate', $datse);
        $result_amount = $this->db->get();
        $amount = $result_amount->result_array();
        $cash += $amount[0]['amount'];
        return $cash;
    }


    public function total_sales_amount(){
       $this->db->select('b.product_id, b.product_name, sum(a.quantity) as quantity,sum(a.total_price) as sales_amount,c.date');
        $this->db->from('invoice_details a');
        $this->db->join('invoice c', 'c.invoice_id = a.invoice_id');
        $this->db->join('product_information b', 'b.product_id = a.product_id');
        $this->db->where('MONTH(c.date)',date('m'));
        $query = $this->db->get();
         $total =  $query->row()->quantity;   
        return (!empty($total)?$total:0);
    }

    public function monthlyprogress_label($year,$month){
        $mlabel = '';
        for($d=1; $d<=31; $d++)
        {
            $time=mktime(12, 0, 0, $month, $d, $year);          
            if (date('m', $time)==$month)       
                
             $mlabel .= date('Y-m-d', $time). ', ';
        } 
        return  $mlabel;
    }

    public function monthlyprogress_saledata($year,$month){
        $salesdata = '';
        for($d=1; $d<=31; $d++)
        {
            $time=mktime(12, 0, 0, $month, $d, $year);          
            if (date('m', $time)==$month)       
                
             $saledate = date('Y-m-d', $time);
             $salesdata .= $this->progress_saledata($saledate). ', ';
        } 
        return  $salesdata;
    }

    public function monthlyprogress_purchasedata($year,$month){
        $purchasedata = '';
        for($d=1; $d<=31; $d++)
        {
            $time=mktime(12, 0, 0, $month, $d, $year);          
            if (date('m', $time)==$month)       
                
             $purchasedate = date('Y-m-d', $time);
             $purchasedata .= $this->progress_purchasedata($purchasedate). ', ';
        } 
        return  $purchasedata;
    }

    public function progress_saledata($date){
        $this->db->select("sum(total_amount) as total");
        $this->db->from('invoice');
        $this->db->where('date',$date); 
        $query = $this->db->get();
            $amount =  $query->row()->total;   
        return (!empty($amount)?$amount:0);
    }

    public function pie_total_saleamount(){
        $month = date('m');
        $year  = date('Y');
        $this->db->select("sum(total_amount) as total");
        $this->db->from('invoice');
        $this->db->where('YEAR(date)',$year);
        $this->db->where('MONTH(date)',$month); 
        $query = $this->db->get();
            $amount =  $query->row()->total;   
        return (!empty($amount)?$amount:0);
    }

    public function pie_total_purchaseamount(){
        $month = date('m');
        $year  = date('Y');
        $this->db->select("sum(grand_total_amount) as total");
        $this->db->from('product_purchase');
        $this->db->where('YEAR(purchase_date)',$year);
        $this->db->where('MONTH(purchase_date)',$month);  
        $query = $this->db->get();
            $amount =  $query->row()->total;   
        return (!empty($amount)?$amount:0);
    }

    public function pie_total_serviceamount(){
        $month = date('m');
        $year  = date('Y');
        $this->db->select("sum(total_amount) as total");
        $this->db->from('service_invoice');
        $this->db->where('YEAR(date)',$year);
        $this->db->where('MONTH(date)',$month);  
        $query = $this->db->get();
            $amount =  $query->row()->total;   
        return (!empty($amount)?$amount:1);
    }

    public function pie_total_salaryamount(){
        $month = date('m');
        $year  = date('Y');
        $this->db->select("sum(total_salary) as total");
        $this->db->from('employee_salary_payment');
        $this->db->where('YEAR(payment_date)',$year);
        $this->db->where('MONTH(payment_date)',$month);
        $this->db->where('paid_by !=',NULL);  
        $query = $this->db->get();
            $amount =  $query->row()->total;   
        return (!empty($amount)?$amount:0);
    }
   
   public function pie_total_expenseamount(){
        $expense_amount = 0;
        $month = date('m');
        $year  = date('Y');
        $this->db->select('*');
        $this->db->from('acc_coa');
        $this->db->where('PHeadName', 'Expence');
        $query = $this->db->get();
        $result = $query->result_array();
        if($result){
            foreach($result as $data){
        $this->db->select('sum(Debit) as amount');
        $this->db->from('acc_transaction');
        $this->db->where('COAID', $data['HeadCode']);
        $this->db->where('YEAR(VDate)',$year);
        $this->db->where('MONTH(VDate)',$month); 
        $this->db->where('IsAppove', 1);
        $result_amount = $this->db->get();
        $amount = $result_amount->result_array();
        $expense_amount += $amount[0]['amount'];
    }
        }
        return $expense_amount;

   }
    public function progress_purchasedata($date){
         $this->db->select("sum(grand_total_amount) as total");
        $this->db->from('product_purchase');
        $this->db->where('purchase_date',$date); 
        $query = $this->db->get();
            $amount =  $query->row()->total;   
        return (!empty($amount)?$amount:0);
    }

    public function total_cash_receive(){
        $cash = 0;
        $datse = date('Y-m-d');
        $this->db->select('sum(Debit) as amount');
        $this->db->from('acc_transaction');
        $this->db->where('COAID', 1020101);
        $this->db->where('VDate', $datse);
        $this->db->where('IsAppove', 1);
        $result_amount = $this->db->get();
        $amount = $result_amount->result_array();
        $cash = $amount[0]['amount'];
        return $cash;
    }

    public function total_bank_receive(){
        $bank_amount = 0;
        $datse = date('Y-m-d');
        $this->db->select('*');
        $this->db->from('acc_coa');
        $this->db->where('PHeadName', 'Cash At Bank');
        $query = $this->db->get();
        $result = $query->result_array();
        if($result){
            foreach($result as $data){
        $this->db->select('sum(Debit) as amount');
        $this->db->from('acc_transaction');
        $this->db->where('COAID', $data['HeadCode']);
        $this->db->where('VDate', $datse);
        $this->db->where('IsAppove', 1);
        $result_amount = $this->db->get();
        $amount = $result_amount->result_array();
        $bank_amount += $amount[0]['amount'];
    }
        }
        return $bank_amount;

    }

        public function total_due_amount(){
        $date = date('Y-m-d');
        $this->db->select("sum(a.due_amount) as total,b.date");
        $this->db->from('invoice_details a');
        $this->db->join('invoice b','b.invoice_id = a.invoice_id');
        $this->db->where('b.date',$date);
        $this->db->group_by('a.invoice_id'); 
        $query = $this->db->get();
        $result = $query->result_array();
        $total_due = 0;
        foreach($result as $data){
           $total_due += $data['total'];
            
    }

       return $total_due;
        }


        public function total_service_amount(){
        $date = date('Y-m-d');
        $this->db->select("sum(total_amount) as total");
        $this->db->from('service_invoice');
        $this->db->where('date',$date);
        $query = $this->db->get();
            $amount =  $query->row()->total;
        return (!empty($amount)?$amount:0);
    }

    # =================================================================
    # RINGKASAN DASHBOARD (Hari Ini / Minggu Ini / Bulan Ini / Tahun Ini)
    #
    # Semua angka di bawah dihitung dari invoice + invoice_details,
    # karena di situlah transaksi penjualan yang benar-benar terjadi
    # tercatat.
    #
    # Harga beli (modal) diambil dari product_purchase_details.rate
    # yang dicocokkan lewat product_id + batch_id. Alasannya:
    # kolom invoice_details.manufacturer_rate dan
    # product_information.manufacturer_price di database ini hampir
    # seluruhnya kosong, sehingga kalau dipakai, modal terbaca 0 dan
    # gross margin akan tampil ~100% - menyesatkan. Harga beli per
    # batch juga lebih tepat, sebab satu produk bisa dibeli dengan
    # harga berbeda di tiap batch.
    #
    # Pencocokan memakai subquery berkorelasi (bukan JOIN biasa),
    # karena satu kombinasi product_id + batch_id kadang punya lebih
    # dari satu baris pembelian. Dengan JOIN, baris penjualan akan
    # terduplikasi dan jumlah barang serta omzet ikut menggelembung.
    # =================================================================

    /**
     * Potongan SQL untuk modal (harga beli) satu baris invoice_details.
     * Dipakai berulang di beberapa query ringkasan.
     *
     * @return string
     */
    private function dashboard_cost_expression()
    {
        return "COALESCE((SELECT pd.rate
                            FROM product_purchase_details pd
                           WHERE pd.product_id = d.product_id
                             AND pd.batch_id   = d.batch_id
                        ORDER BY pd.id DESC
                           LIMIT 1), 0)";
    }

    /**
     * Ringkasan satu periode: jumlah obat terjual, nilai jual, nilai
     * modal, gross margin, jumlah transaksi, dan jumlah pelanggan.
     *
     * @param string $from_date Y-m-d
     * @param string $to_date   Y-m-d
     * @return array
     */
    public function dashboard_summary($from_date, $to_date)
    {
        $cost = $this->dashboard_cost_expression();

        $sql = "SELECT
                    COALESCE(SUM(d.quantity), 0)                  AS total_qty,
                    COALESCE(SUM(d.total_price), 0)               AS total_sell,
                    COALESCE(SUM(d.quantity * {$cost}), 0)        AS total_cost,
                    COUNT(DISTINCT i.invoice_id)                  AS total_invoice,
                    COUNT(DISTINCT i.customer_id)                 AS total_customer
                  FROM invoice i
                  JOIN invoice_details d ON d.invoice_id = i.invoice_id
                 WHERE i.date BETWEEN ? AND ?";

        $row = $this->db->query($sql, array($from_date, $to_date))->row_array();

        return $this->dashboard_format_summary($row);
    }

    /**
     * Lengkapi hasil query ringkasan dengan gross margin dan
     * persentasenya, sekaligus jaga-jaga bila query tidak mengembalikan
     * baris sama sekali.
     *
     * @param array|null $row
     * @return array
     */
    private function dashboard_format_summary($row)
    {
        $qty   = (!empty($row['total_qty'])      ? (float) $row['total_qty']      : 0);
        $sell  = (!empty($row['total_sell'])     ? (float) $row['total_sell']     : 0);
        $cost  = (!empty($row['total_cost'])     ? (float) $row['total_cost']     : 0);
        $inv   = (!empty($row['total_invoice'])  ? (int)   $row['total_invoice']  : 0);
        $cust  = (!empty($row['total_customer']) ? (int)   $row['total_customer'] : 0);

        $margin = $sell - $cost;

        return array(
            'total_qty'      => $qty,
            'total_sell'     => $sell,
            'total_cost'     => $cost,
            'gross_margin'   => $margin,
            // Margin dibagi omzet (bukan modal), sesuai definisi umum
            // gross margin. Dijaga agar tidak membagi nol.
            'margin_percent' => ($sell > 0 ? ($margin / $sell) * 100 : 0),
            'total_invoice'  => $inv,
            'total_customer' => $cust,
        );
    }

    /**
     * 10 barang paling laku pada satu periode, diurutkan dari jumlah
     * terjual terbanyak.
     *
     * @param string $from_date Y-m-d
     * @param string $to_date   Y-m-d
     * @param int    $limit
     * @return array
     */
    public function dashboard_top_products($from_date, $to_date, $limit = 10)
    {
        $cost = $this->dashboard_cost_expression();

        $sql = "SELECT
                    d.product_id,
                    p.product_name,
                    COALESCE(SUM(d.quantity), 0)           AS total_qty,
                    COALESCE(SUM(d.total_price), 0)        AS total_sell,
                    COALESCE(SUM(d.quantity * {$cost}), 0) AS total_cost
                  FROM invoice i
                  JOIN invoice_details d ON d.invoice_id = i.invoice_id
             LEFT JOIN product_information p ON p.product_id = d.product_id
                 WHERE i.date BETWEEN ? AND ?
              GROUP BY d.product_id
              ORDER BY total_qty DESC, total_sell DESC
                 LIMIT ".(int) $limit;

        $rows = $this->db->query($sql, array($from_date, $to_date))->result_array();

        $products = array();
        foreach ($rows as $row) {
            $sell = (float) $row['total_sell'];
            $margin = $sell - (float) $row['total_cost'];
            $products[] = array(
                'product_id'   => $row['product_id'],
                // Produk yang sudah dihapus tetap tampil, tapi diberi
                // penanda agar tidak muncul sebagai baris kosong.
                'product_name' => (!empty($row['product_name']) ? $row['product_name'] : '('.display('product_name').' -)'),
                'total_qty'    => (float) $row['total_qty'],
                'total_sell'   => $sell,
                'total_cost'   => (float) $row['total_cost'],
                'gross_margin' => $margin,
            );
        }

        return $products;
    }

    /**
     * Rincian ringkasan per potongan waktu, dipakai untuk tabel dan
     * grafik breakdown (per hari, per minggu, atau per bulan).
     *
     * $buckets berisi daftar array dengan kunci 'label', 'from', 'to'.
     *
     * Sebelumnya tiap potongan waktu dihitung lewat query sendiri.
     * Untuk laporan tahunan itu berarti 12 query berturut-turut yang
     * masing-masing memindai tabel penjualan - halaman jadi lambat.
     * Sekarang cukup SATU query yang mengelompokkan penjualan per
     * tanggal, lalu hasilnya dijumlahkan ke tiap potongan di PHP.
     *
     * @param array $buckets
     * @return array
     */
    public function dashboard_breakdown($buckets)
    {
        if (empty($buckets)) {
            return array();
        }

        // Rentang menyeluruh dari potongan paling awal sampai paling akhir.
        $range_from = $buckets[0]['from'];
        $range_to   = $buckets[0]['to'];
        foreach ($buckets as $bucket) {
            if ($bucket['from'] < $range_from) { $range_from = $bucket['from']; }
            if ($bucket['to']   > $range_to)   { $range_to   = $bucket['to']; }
        }

        $daily = $this->dashboard_daily_rows($range_from, $range_to);

        $rows = array();
        foreach ($buckets as $bucket) {
            $qty = $sell = $cost = 0;
            $invoice_total = 0;
            $customers = array();

            foreach ($daily as $date => $day) {
                if ($date < $bucket['from'] || $date > $bucket['to']) {
                    continue;
                }
                $qty  += $day['total_qty'];
                $sell += $day['total_sell'];
                $cost += $day['total_cost'];
                // Satu invoice hanya muncul pada satu tanggal, jadi
                // jumlahnya aman untuk ditambahkan langsung.
                $invoice_total += $day['total_invoice'];
                // Pelanggan bisa berbelanja di beberapa hari, karena
                // itu id-nya dikumpulkan dulu baru dihitung unik.
                foreach ($day['customers'] as $customer_id) {
                    $customers[$customer_id] = true;
                }
            }

            $summary = $this->dashboard_format_summary(array(
                'total_qty'      => $qty,
                'total_sell'     => $sell,
                'total_cost'     => $cost,
                'total_invoice'  => $invoice_total,
                'total_customer' => count($customers),
            ));

            $summary['label'] = $bucket['label'];
            $summary['from']  = $bucket['from'];
            $summary['to']    = $bucket['to'];
            $rows[] = $summary;
        }

        return $rows;
    }

    /**
     * Rekap penjualan per tanggal dalam satu rentang, sebagai bahan
     * mentah untuk menyusun breakdown.
     *
     * @param string $from_date Y-m-d
     * @param string $to_date   Y-m-d
     * @return array Berindeks tanggal (Y-m-d)
     */
    private function dashboard_daily_rows($from_date, $to_date)
    {
        $cost = $this->dashboard_cost_expression();

        $sql = "SELECT
                    i.date                                        AS sale_date,
                    COALESCE(SUM(d.quantity), 0)                  AS total_qty,
                    COALESCE(SUM(d.total_price), 0)               AS total_sell,
                    COALESCE(SUM(d.quantity * {$cost}), 0)        AS total_cost,
                    COUNT(DISTINCT i.invoice_id)                  AS total_invoice,
                    GROUP_CONCAT(DISTINCT i.customer_id)          AS customer_ids
                  FROM invoice i
                  JOIN invoice_details d ON d.invoice_id = i.invoice_id
                 WHERE i.date BETWEEN ? AND ?
              GROUP BY i.date";

        $result = $this->db->query($sql, array($from_date, $to_date))->result_array();

        $daily = array();
        foreach ($result as $row) {
            $daily[$row['sale_date']] = array(
                'total_qty'     => (float) $row['total_qty'],
                'total_sell'    => (float) $row['total_sell'],
                'total_cost'    => (float) $row['total_cost'],
                'total_invoice' => (int) $row['total_invoice'],
                'customers'     => (!empty($row['customer_ids']) ? explode(',', $row['customer_ids']) : array()),
            );
        }

        return $daily;
    }
}