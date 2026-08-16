<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Creport extends CI_Controller {
	
	function __construct() {
     	parent::__construct();
      	$CI =& get_instance();
      	$CI->load->model('Web_settings');
    }
	public function index()
    {
       $CI =& get_instance();
        $this->auth->check_admin_auth();
        $CI->load->library('lreport');
       
        $content = $CI->lreport->stock_report_single_item();
        
        $this->template->full_admin_html_view($content); 
    }


public function CheckList(){
        // GET data
        $this->load->model('Reports');
        $postData = $this->input->post();
        $data = $this->Reports->getCheckList($postData);
        echo json_encode($data);
    }

    /**
     * Simpan harga jual yang diubah langsung dari tabel Laporan Stock
     * (klik dua kali pada kolom Harga Jual).
     *
     * Menjawab lewat JSON supaya tabel bisa memperbarui satu baris saja
     * tanpa memuat ulang halaman.
     */
    public function update_sales_price()
    {
        $this->auth->check_admin_auth();
        header('Content-Type: application/json');

        // Mengubah harga jual = mengubah data barang, jadi izinnya
        // mengikuti hak "ubah" pada menu Obat - bukan sekadar hak baca
        // laporan. Pengguna yang hanya boleh melihat laporan tidak bisa
        // mengubah harga.
        if (!$this->permission1->method('manage_medicine','update')->access()) {
            echo json_encode(array(
                'status'  => false,
                'message' => display('you_are_not_access_this_part'),
            ));
            return;
        }

        $this->load->model('Reports');

        $product_id = $this->input->post('product_id', true);
        $price      = $this->input->post('price', true);

        // Pemisah ribuan dari tampilan dibuang lebih dulu, supaya pengguna
        // boleh mengetik "12.500", "12,500", maupun "12500". Titik/koma
        // terakhir dianggap desimal hanya bila diikuti 1-2 angka
        // ("12500,50"); selain itu dianggap pemisah ribuan.
        $price = trim((string) $price);
        $price = preg_replace('/\s+/', '', $price);
        if (preg_match('/^(.*)[.,](\d{1,2})$/', $price, $m)) {
            $price = preg_replace('/[.,]/', '', $m[1]).'.'.$m[2];
        } else {
            $price = preg_replace('/[.,]/', '', $price);
        }

        if ($product_id === null || $product_id === '') {
            echo json_encode(array('status' => false, 'message' => 'Barang tidak dikenali.'));
            return;
        }
        if ($price === '' || !is_numeric($price)) {
            echo json_encode(array('status' => false, 'message' => 'Harga jual harus berupa angka.'));
            return;
        }
        if ((float) $price < 0) {
            echo json_encode(array('status' => false, 'message' => 'Harga jual tidak boleh negatif.'));
            return;
        }

        if (!$this->Reports->update_sales_price($product_id, (float) $price)) {
            echo json_encode(array('status' => false, 'message' => 'Barang tidak ditemukan.'));
            return;
        }

        echo json_encode(array(
            'status'  => true,
            'price'   => (float) $price,
            'message' => display('successfully_updated'),
        ));
    }

    // Isi dropdown filter (nama barang & faktur pembelian) untuk Laporan Stock.
    public function stock_filter_options(){
        $this->auth->check_admin_auth();
        $this->load->model('Reports');
        $scope = ($this->input->get('scope',true) === 'purchased' ? 'purchased' : 'all');
        header('Content-Type: application/json');
        echo json_encode($this->Reports->getStockFilterOptions($scope));
    }

        public function exportCSV(){ 
   // file name 
    $this->load->model('Reports');
    $usersData = $this->Reports->stock_csv_file();
   $filename = 'stock_'.date('Ymd').'.csv'; 
   header("Content-Description: File Transfer"); 
   header("Content-Disposition: attachment; filename=$filename"); 
   header("Content-Type: application/csv; ");
   
   // get data 
   $usersData = $this->Reports->stock_csv_file();

   // file creation 
   $file = fopen('php://output', 'w');
 
   $header = array('Product Id','Product Name','Product Model','Sell Price','Purchase Price','Total In Qty','Total Out Qty','Stock','Stock Purhcase Amount','Stock Sale Amount'); 
   fputcsv($file, $header);
   foreach ($usersData as $line){ 
     fputcsv($file,$line); 
   }
   fclose($file); 
   exit; 
  }

	
	public function out_of_stock(){
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		$CI->load->library('lreport');

		$content = $CI->lreport->out_of_stock();
        
		$this->template->full_admin_html_view($content);
	}

    public function CheckStockOutList(){
        // GET data
        $this->load->model('Reports');
        $postData = $this->input->post();
        $data = $this->Reports->getStockOutList($postData);
        echo json_encode($data);
    } 
	// Date Expire Medicine list
	public function out_of_date(){
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		$CI->load->library('lreport');

		$content = $CI->lreport->out_of_date();
        
		$this->template->full_admin_html_view($content);
	}

public function CheckExpireList(){
        // GET data
        $this->load->model('Reports');
        $postData = $this->input->post();
        $data = $this->Reports->getExpireList($postData);
        echo json_encode($data);
    }

	// Daftar obat MENDEKATI kedaluwarsa
	public function near_expiry(){
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		$CI->load->library('lreport');
		$content = $CI->lreport->near_expiry();
		$this->template->full_admin_html_view($content);
	}

	public function CheckNearExpiryList(){
		$this->load->model('Reports');
		$postData = $this->input->post();
		$data = $this->Reports->getNearExpiryList($postData);
		echo json_encode($data);
	}



	//Get product by manufacturer
	public function get_product_by_manufacturer(){
		$manufacturer_id = $this->input->post('manufacturer_id',true);

		$product_info_by_manufacturer = $this->db->select('a.*,b.*')
											->from('product_information a')
											->join('manufacturer_product b','a.product_id=b.product_id')
											->where('b.manufacturer_id',$manufacturer_id)
											->get()
											->result();

		if ($product_info_by_manufacturer) {
			echo "<select class=\"form-control\" id=\"manufacturer_id\" name=\"manufacturer_id\">
	                <option value=\"\">".display('select_one')."</option>";
			foreach ($product_info_by_manufacturer as $product) {
				echo "<option value='".$product->product_id."'>".medicine_name($product->product_name,$product->product_model,'-')." </option>";
			}
			echo " </select>";
		}

	}


	#===============Report paggination=============#
	public function pagination($per_page,$page)
	{
		$CI =& get_instance();
		$CI->load->model('Reports');
		$product_id=$this->input->post('product_id',true);	
		
		$config = array();
		$config["base_url"] = base_url().$page;
		$config["total_rows"] = $this->Reports->product_counter($product_id);
		$config["per_page"] = $per_page;
		$config["uri_segment"] = 4;	
        $config["num_links"] = 5; 
        /* This Application Must Be Used With BootStrap 3 * */
        $config['full_tag_open'] = "<ul class='pagination'>";
        $config['full_tag_close'] = "</ul>";
        $config['num_tag_open'] = '<li>';
        $config['num_tag_close'] = '</li>';
        $config['cur_tag_open'] = "<li class='disabled'><li class='active'><a href='#'>";
        $config['cur_tag_close'] = "<span class='sr-only'></span></a></li>";
        $config['next_tag_open'] = "<li>";
        $config['next_tag_close'] = "</li>";
        $config['prev_tag_open'] = "<li>";
        $config['prev_tagl_close'] = "</li>";
        $config['first_tag_open'] = "<li>";
        $config['first_tagl_close'] = "</li>";
        $config['last_tag_open'] = "<li>";
        $config['last_tagl_close'] = "</li>";



		$this->pagination->initialize($config);
		
		$page = ($this->uri->segment(4)) ? $this->uri->segment(4) : 0;
		$limit = $config["per_page"];
	    return $links = $this->pagination->create_links();	
	}


        public function stock_report_batch_wise(){
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        $CI->load->library('lreport');  
        $CI->load->model('Reports');
        $content =$this->lreport->stock_report_batch_wise();
        $this->template->full_admin_html_view($content);
    }



    public function Checkbatchstock(){
        // GET data
        $this->load->model('Reports');
        $postData = $this->input->post();
        $data = $this->Reports->getCheckBatchStock($postData);
        echo json_encode($data);
    } 

    
	
}