<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Admin_dashboard extends CI_Controller {
	
	function __construct() {
      	parent::__construct();
	  	$this->template->current_menu = 'home';
	  	$this->load->model('Web_settings');
    }

    public function index(){
    	$CI =& get_instance();
		$CI->load->library('lreport');
		$CI->load->library('occational');
		if (!$this->auth->is_logged())
		{
		$this->output->set_header("Location: ".base_url().'Admin_dashboard/login', TRUE, 302);
		}
		$this->auth->check_admin_auth();

	  	$CI->load->model('Customers');
	    $CI->load->model('Products');
	    $CI->load->model('Manufacturers');
	    $CI->load->model('Invoices');
	    $CI->load->model('Purchases');
	    $CI->load->model('Reports');
	    $CI->load->model('Web_settings');
	    $total_customer      = $CI->Customers->count_customer();
	    $total_product       = $CI->Products->count_product();
	    $total_manufacturers = $CI->Manufacturers->count_manufacturer();
	    $total_sales         = $CI->Invoices->count_invoice();
	    $total_purchase      = $CI->Reports->todays_total_purchase();
	    $out_of_stock        = $CI->Reports->out_of_stock_count();
	    $out_of_date         = $CI->Reports->out_of_date_count();
      	$monthly_sales_report= 0;
	    $sales_report        = $CI->Reports->todays_total_sales_report();	
		$currency_details    = $CI->Web_settings->retrieve_setting_editdata();
		$best_sales_product  = $CI->Invoices->best_sales_products();
		$total_sales_amount  = $CI->Reports->total_sales_amount();
		$total_cash_receive  = $CI->Reports->total_cash_receive();
		$total_bank_receive  = $CI->Reports->total_bank_receive();
		$total_due_amount    = $CI->Reports->total_due_amount();
		$total_service_amount= $CI->Reports->total_service_amount();
		$pie_total_sale      = $CI->Reports->pie_total_saleamount();
		$pie_total_purchase  = $CI->Reports->pie_total_purchaseamount();
		$pie_total_service   = $CI->Reports->pie_total_serviceamount();
		$pie_total_expense   = $CI->Reports->pie_total_expenseamount();
		$pie_total_salary    = $CI->Reports->pie_total_salaryamount();

		// Kartu KPI kondisi persediaan. Empat angka ini yang paling sering
		// perlu ditindaklanjuti, jadi ditaruh di bagian atas dashboard dan
		// masing-masing menuju halaman rinciannya.
		$kpi_cards = array(
			array(
				'label' => 'Total Stok Habis',
				'value' => $CI->Reports->empty_stock_count(),
				'icon'  => 'fa-times-circle',
				'bg'    => 'bg-danger',
				'url'   => base_url('Creport/out_of_stock').'?state=habis',
				'note'  => 'Stok tersisa 0',
			),
			array(
				'label' => 'Total Stok Kritis',
				'value' => $CI->Reports->critical_stock_count(),
				'icon'  => 'fa-exclamation-triangle',
				'bg'    => 'bg-orange',
				'url'   => base_url('Creport/out_of_stock').'?state=kritis',
				'note'  => 'Stok < penjualan bulan lalu',
			),
			array(
				'label' => 'Total Obat Mendekati Kedaluwarsa',
				'value' => $CI->Reports->near_expiry_count(),
				'icon'  => 'fa-clock-o',
				'bg'    => 'bg-green',
				'url'   => base_url('Creport/near_expiry'),
				'note'  => 'Masih ada stok',
			),
			array(
				'label' => 'Total Obat Kedaluwarsa',
				'value' => $CI->Reports->out_of_date_count(),
				'icon'  => 'fa-ban',
				'bg'    => 'bg-bringal',
				'url'   => base_url('Creport/out_of_date'),
				'note'  => 'Sudah lewat tanggal',
			),
		);

		// Ringkasan empat periode untuk kartu di bagian atas dashboard.
		// Tiap kartu memakai rentang tanggal yang sama persis dengan
		// halaman detailnya, sehingga angkanya selalu cocok saat diklik.
		$dashboard_periods = array();
		foreach (array('today','week','month','year') as $period_key) {
			$range = $this->dashboard_period($period_key);
			$dashboard_periods[$period_key] = array(
				'key'     => $period_key,
				'title'   => $range['title'],
				'from'    => $range['from'],
				'to'      => $range['to'],
				'summary' => $CI->Reports->dashboard_summary($range['from'], $range['to']),
				'top'     => $CI->Reports->dashboard_top_products($range['from'], $range['to'], 10),
			);
		}

        $chart_label = $chart_data = '';
		if (!empty($best_sales_product))
		    for ($i = 0; $i < 50; $i++) {
		        $chart_label .= (!empty($best_sales_product[$i]) ?  $best_sales_product[$i]->product_name . ', ' : null);
		        $chart_data .= (!empty($best_sales_product[$i]) ? $best_sales_product[$i]->quantity . ', ' : null);
		    }
	    $data = array(
	    	'title' 			=> display('dashboard'), 
	    	'total_customer' 	=> $total_customer,
	    	'total_product' 	=> $total_product,
	    	'total_manufacturers'=> $total_manufacturers,
	    	'total_sales' 		=> $total_sales,
	    	'total_purchase' 	=> $total_purchase,
	    	'stockout'          => (!empty($out_of_stock)?$out_of_stock:0),
	    	'expired'           => (!empty($out_of_date)?$out_of_date:0),
	    	'purchase_amount' 	=> (!empty($total_purchase[0]['total_purchase'])?number_format($total_purchase[0]['total_purchase'], 2, '.', ','):0),
	    	'sales_amount' 		=> (!empty($sales_report[0]['total_sale'])?number_format($sales_report[0]['total_sale'], 2, '.', ','):0),
	    	'currency' 			=> $currency_details[0]['currency'],
			'position' 			=> $currency_details[0]['currency_position'],
			'chart_label'       => $chart_label,
            'chart_data'        => $chart_data,
            'total_sales_amount'=> $total_sales_amount,
            'total_cash_receive'=> (!empty($total_cash_receive)?number_format($total_cash_receive, 2, '.', ','):0),
             'total_bank_receive'=> (!empty($total_bank_receive)?number_format($total_bank_receive, 2, '.', ','):0),
             'total_due_amount' => (!empty($total_due_amount)?number_format($total_due_amount, 2, '.', ','):0),
             'total_service_amount'=> (!empty($total_service_amount)?number_format($total_service_amount, 2, '.', ','):0),
             'pie_total_sale'     => $pie_total_sale,
             'pie_total_purchase' => $pie_total_purchase,
             'pie_total_service'  => $pie_total_service,
             'pie_total_expense'  => $pie_total_expense,
             'pie_total_salary'   => $pie_total_salary,
             'dashboard_periods'  => $dashboard_periods,
             'kpi_cards'          => $kpi_cards,
	    	);

		$content = $CI->parser->parse('include/admin_home',$data,true);
		$this->template->full_admin_html_view($content);
		
    }
	# =================================================================
	# RINGKASAN PERIODE DASHBOARD
	#
	# Empat kartu di dashboard (Hari Ini, Minggu Ini, Bulan Ini, Tahun
	# Ini) memakai perhitungan yang sama, hanya beda rentang tanggal.
	# Rentang itu ditentukan sekali di sini supaya tampilan ringkas di
	# dashboard dan halaman detailnya tidak pernah berbeda angka.
	# =================================================================

	/**
	 * Rentang tanggal tiap periode beserta judul dan cara memecah
	 * breakdown-nya.
	 *
	 * @param string $period today|week|month|year
	 * @return array|false
	 */
	private function dashboard_period($period)
	{
		$today = date('Y-m-d');

		switch ($period) {
			case 'today':
				return array(
					'title' => 'Detail Hari Ini',
					'from'  => $today,
					'to'    => $today,
				);

			case 'week':
				// Minggu berjalan dihitung Senin s/d Minggu. 'monday
				// this week' di PHP sudah mengikuti aturan itu, termasuk
				// ketika hari ini kebetulan hari Minggu.
				return array(
					'title' => 'Detail Minggu Ini',
					'from'  => date('Y-m-d', strtotime('monday this week', strtotime($today))),
					'to'    => date('Y-m-d', strtotime('sunday this week', strtotime($today))),
				);

			case 'month':
				return array(
					'title' => 'Detail Bulan Ini',
					'from'  => date('Y-m-01'),
					'to'    => date('Y-m-t'),
				);

			case 'year':
				return array(
					'title' => 'Detail Tahun Ini',
					'from'  => date('Y-01-01'),
					'to'    => date('Y-12-31'),
				);
		}

		return false;
	}

	/**
	 * Potongan waktu untuk tabel/grafik breakdown tiap periode:
	 * minggu dipecah per hari, bulan per minggu, tahun per bulan.
	 * Periode "hari ini" tidak dipecah lagi.
	 *
	 * @param string $period
	 * @param array  $range
	 * @return array
	 */
	private function dashboard_buckets($period, $range)
	{
		$buckets = array();

		if ($period == 'week') {
			$hari = array('Minggu','Senin','Selasa','Rabu','Kamis','Jumat','Sabtu');
			$cursor = strtotime($range['from']);
			$end    = strtotime($range['to']);
			while ($cursor <= $end) {
				$date = date('Y-m-d', $cursor);
				$buckets[] = array(
					'label' => $hari[(int) date('w', $cursor)].', '.date('d/m', $cursor),
					'from'  => $date,
					'to'    => $date,
				);
				$cursor = strtotime('+1 day', $cursor);
			}
		} elseif ($period == 'month') {
			// Bulan dipecah per blok 7 hari (1-7, 8-14, ...). Blok
			// terakhir dipotong di tanggal akhir bulan supaya tidak
			// bocor ke bulan berikutnya.
			$last_day = (int) date('t', strtotime($range['from']));
			$week_no  = 1;
			for ($start = 1; $start <= $last_day; $start += 7) {
				$stop = min($start + 6, $last_day);
				$buckets[] = array(
					'label' => 'Minggu '.$week_no.' ('.$start.'-'.$stop.')',
					'from'  => date('Y-m-', strtotime($range['from'])).sprintf('%02d', $start),
					'to'    => date('Y-m-', strtotime($range['from'])).sprintf('%02d', $stop),
				);
				$week_no++;
			}
		} elseif ($period == 'year') {
			$bulan = array('Januari','Februari','Maret','April','Mei','Juni',
						   'Juli','Agustus','September','Oktober','November','Desember');
			$year = date('Y', strtotime($range['from']));
			for ($m = 1; $m <= 12; $m++) {
				$first = $year.'-'.sprintf('%02d', $m).'-01';
				$buckets[] = array(
					'label' => $bulan[$m - 1],
					'from'  => $first,
					'to'    => date('Y-m-t', strtotime($first)),
				);
			}
		}

		return $buckets;
	}

	/**
	 * Halaman detail satu periode: ringkasan angka, breakdown per
	 * potongan waktu, dan 10 barang paling laku.
	 *
	 * @param string $period
	 */
	public function period_detail($period = 'today')
	{
		$CI =& get_instance();
		$this->auth->check_admin_auth();

		if (!$this->permission1->method('todays_report','read')->access()) {
			$this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
			redirect('Admin_dashboard');
		}

		$range = $this->dashboard_period($period);
		if ($range === false) {
			redirect('Admin_dashboard');
		}

		$CI->load->model('Reports');
		$CI->load->model('Web_settings');

		$currency_details = $CI->Web_settings->retrieve_setting_editdata();

		#
		# Paginasi tabel rincian seluruh barang terjual.
		#
		# Segmen 3 URL sudah dipakai nama periode
		# (Admin_dashboard/period_detail/year), jadi nomor baris awal
		# halaman ditaruh di segmen 4.
		#
		$per_page = 25;
		$total_rows = $CI->Reports->dashboard_all_products_count($range['from'], $range['to']);

		$config = array();
		$config['base_url']       = base_url('Admin_dashboard/period_detail/'.$period);
		$config['total_rows']     = $total_rows;
		$config['per_page']       = $per_page;
		$config['uri_segment']    = 4;
		$config['num_links']      = 3;
		/* Mengikuti gaya paginasi BootStrap 3 seperti laporan lain */
		$config['full_tag_open']  = "<ul class='pagination'>";
		$config['full_tag_close'] = "</ul>";
		$config['num_tag_open']   = '<li>';
		$config['num_tag_close']  = '</li>';
		$config['cur_tag_open']   = "<li class='disabled'><li class='active'><a href='#'>";
		$config['cur_tag_close']  = "<span class='sr-only'></span></a></li>";
		$config['next_tag_open']  = "<li>";
		$config['next_tag_close'] = "</li>";
		$config['prev_tag_open']  = "<li>";
		$config['prev_tagl_close']= "</li>";
		$config['first_tag_open'] = "<li>";
		$config['first_tagl_close']= "</li>";
		$config['last_tag_open']  = "<li>";
		$config['last_tagl_close']= "</li>";

		$this->pagination->initialize($config);

		// Segmen 4 berisi nomor baris awal, bukan nomor halaman.
		$offset = (int) $this->uri->segment(4);
		if ($offset < 0 || $offset >= $total_rows) {
			$offset = 0;
		}

		$data = array(
			'title'         => $range['title'],
			'period'        => $period,
			'period_title'  => $range['title'],
			'from_date'     => $range['from'],
			'to_date'       => $range['to'],
			'summary'       => $CI->Reports->dashboard_summary($range['from'], $range['to']),
			'breakdown'     => $CI->Reports->dashboard_breakdown($this->dashboard_buckets($period, $range)),
			'top_products'  => $CI->Reports->dashboard_top_products($range['from'], $range['to'], 10),
			'all_products'  => $CI->Reports->dashboard_all_products($range['from'], $range['to'], $per_page, $offset),
			'total_rows'    => $total_rows,
			'offset'        => $offset,
			'per_page'      => $per_page,
			'links'         => $this->pagination->create_links(),
			'currency'      => $currency_details[0]['currency'],
			'position'      => $currency_details[0]['currency_position'],
		);

		$content = $CI->load->view('include/dashboard_period_detail', $data, true);
		$this->template->full_admin_html_view($content);
	}

    //Today All Report
	public function all_report()
	{
		$CI =& get_instance();
		$CI->load->library('lreport');
		$content = $CI->lreport->retrieve_all_reports();
		$this->template->full_admin_html_view($content);
	}
	#==============Todays_sales_report============#
	public function todays_sales_report()
	{
		$CI =& get_instance();
		$CI->load->library('lreport');
		$this->auth->check_admin_auth();
		$content = $CI->lreport->todays_sales_report();
		$this->template->full_admin_html_view($content);
	}
	#================todays_purchase_report========#
	public function todays_purchase_report()
	{
		$CI =& get_instance();
		$CI->load->library('lreport');
		$this->auth->check_admin_auth();
		$content = $CI->lreport->todays_purchase_report();
		$this->template->full_admin_html_view($content);
	}
	#=============Total profit report===================#
	public function total_profit_report(){
		// Pakai izin dari Role Permission, bukan kolom user_type mentah.
		// Akun Owner ber-user_type 2, jadi pengecekan lama ikut menutup
		// akses Owner padahal role-nya diberi izin penuh atas laporan.
		if (!$this->permission1->method('profit_loss','read')->access()) {
            $this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
            redirect('Admin_dashboard');
        }
		$CI =& get_instance();
		$CI->load->library('lreport');
		$CI->load->model('Reports');
		$this->auth->check_admin_auth();
		#
        #pagination starts
        #
        $config["base_url"] = base_url('Admin_dashboard/total_profit_report/');
        $config["total_rows"] = $this->Reports->total_profit_report_count();
        $config["per_page"] = 10;
        $config["uri_segment"] = 3;
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
        /* ends of bootstrap */
        $this->pagination->initialize($config);
        $page = ($this->uri->segment(3)) ? $this->uri->segment(3) : 0;
        $links = $this->pagination->create_links();
        #
        #pagination ends
        #  
        $content =$this->lreport->total_profit_report($links,$config["per_page"],$page);

		$this->template->full_admin_html_view($content);
	}
	#==============Date wise profit report=============#
	public function retrieve_dateWise_profit_report()
	{
		if (!$this->permission1->method('profit_loss','read')->access()) {
            $this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
            redirect('Admin_dashboard');
        }
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		$CI->load->library('lreport');
		$start_date = $this->input->post('from_date',true);		
		$end_date   = $this->input->post('to_date',true);	
        $content    = $CI->lreport->retrieve_dateWise_profit_report($start_date,$end_date);
		$this->template->full_admin_html_view($content);
	}
	#============Date wise sales report==============#
	public function retrieve_dateWise_SalesReports()
	{
		if (!$this->permission1->method('sales_report','read')->access()) {
            $this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
            redirect('Admin_dashboard');
        }
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		$CI->load->library('lreport');
		$from_date = $this->input->post('from_date',true);		
		$to_date   = $this->input->post('to_date',true);	
        $content   = $CI->lreport->retrieve_dateWise_SalesReports($from_date,$to_date);
		$this->template->full_admin_html_view($content);
	}	
	#==============Date wise purchase report=============#
	public function retrieve_dateWise_PurchaseReports()
	{
		if (!$this->permission1->method('purchase_report','read')->access()) {
            $this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
            redirect('Admin_dashboard');
        }
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		$CI->load->library('lreport');
		$start_date = $this->input->post('from_date',true);		
		$end_date   = $this->input->post('to_date',true);	
        $content    = $CI->lreport->retrieve_dateWise_PurchaseReports($start_date,$end_date);
		$this->template->full_admin_html_view($content);
	}
	#==============Product sales report date wise===========#
	public function product_sales_reports_date_wise()
	{
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		$CI->load->library('lreport');	
		$CI->load->model('Reports');
		#
        #pagination starts
        #
        $config["base_url"] = base_url('Admin_dashboard/product_sales_reports_date_wise/');
        $config["total_rows"] = $this->Reports->retrieve_product_sales_report_count();
        $config["per_page"] = 10;
        $config["uri_segment"] = 3;
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
        /* ends of bootstrap */
        $this->pagination->initialize($config);
        $page = ($this->uri->segment(3)) ? $this->uri->segment(3) : 0;
        $links = $this->pagination->create_links();
        #
        #pagination ends
        #  
        $content =$this->lreport->get_products_report_sales_view($links,$config["per_page"],$page);

		$this->template->full_admin_html_view($content);
	}
	#==============Product sales search reports============#
	public function product_sales_search_reports()
	{
		if (!$this->permission1->method('sales_report_medicine_wise','read')->access()) {
            $this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
            redirect('Admin_dashboard');
        }
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		$CI->load->library('lreport');
		$from_date = $this->input->get('from_date');		
		$to_date   = $this->input->get('to_date');	
        $content   = $CI->lreport->get_products_search_report($from_date,$to_date);
		$this->template->full_admin_html_view($content);
	}

	# =================================================================
	# UNDUH EXCEL
	#
	# Setiap laporan punya satu aksi unduh yang memakai data dan filter
	# tanggal yang sama dengan tampilan layarnya, jadi isi file selalu
	# cocok dengan tabel yang sedang dilihat pengguna.
	# =================================================================

	/**
	 * Laporan hari ini (penjualan + pembelian) dalam satu file dua sheet.
	 */
	public function all_report_excel()
	{
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		if (!$this->permission1->method('todays_report','read')->access()) {
			$this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
			redirect('Admin_dashboard/all_report');
		}
		$CI->load->library('excel_export');
		$CI->load->model('Reports');

		$today = date('d-m-Y');

		$sales = $this->build_sales_sheet(
			$CI->Reports->todays_sales_report(null, null),
			'Penjualan Hari Ini',
			$today,
			$today
		);
		$purchase = $this->build_purchase_sheet(
			$CI->Reports->todays_purchase_report(null, null),
			'Pembelian Hari Ini',
			$today,
			$today
		);
		$sales['name']    = 'Penjualan';
		$purchase['name'] = 'Pembelian';

		$CI->excel_export->download(
			'laporan_hari_ini_'.date('Ymd').'.xlsx',
			array($sales, $purchase)
		);
	}

	/**
	 * Laporan penjualan. Tanpa parameter tanggal berarti penjualan hari ini;
	 * dengan from_date/to_date berarti rentang hasil pencarian.
	 */
	public function todays_sales_report_excel()
	{
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		if (!$this->permission1->method('sales_report','read')->access()) {
			$this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
			redirect('Admin_dashboard/todays_sales_report');
		}
		$CI->load->library('excel_export');
		$CI->load->model('Reports');

		$from_date = $this->input->get('from_date');
		$to_date   = $this->input->get('to_date');

		if ($from_date && $to_date) {
			$report = $CI->Reports->retrieve_dateWise_SalesReports($from_date, $to_date);
			$label_from = $from_date;
			$label_to   = $to_date;
			$filename   = 'laporan_penjualan_'.date('Ymd', strtotime($from_date)).'_'.date('Ymd', strtotime($to_date)).'.xlsx';
		} else {
			$report = $CI->Reports->todays_sales_report(null, null);
			$label_from = $label_to = date('d-m-Y');
			$filename   = 'laporan_penjualan_'.date('Ymd').'.xlsx';
		}

		$sheet = $this->build_sales_sheet($report, 'Laporan Penjualan', $label_from, $label_to);
		$sheet['name'] = 'Penjualan';

		$CI->excel_export->download($filename, array($sheet));
	}

	/**
	 * Laporan pembelian, mengikuti pola yang sama dengan laporan penjualan.
	 */
	public function todays_purchase_report_excel()
	{
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		if (!$this->permission1->method('purchase_report','read')->access()) {
			$this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
			redirect('Admin_dashboard/todays_purchase_report');
		}
		$CI->load->library('excel_export');
		$CI->load->model('Reports');

		$from_date = $this->input->get('from_date');
		$to_date   = $this->input->get('to_date');

		if ($from_date && $to_date) {
			$report = $CI->Reports->retrieve_dateWise_PurchaseReports($from_date, $to_date);
			$label_from = $from_date;
			$label_to   = $to_date;
			$filename   = 'laporan_pembelian_'.date('Ymd', strtotime($from_date)).'_'.date('Ymd', strtotime($to_date)).'.xlsx';
		} else {
			$report = $CI->Reports->todays_purchase_report(null, null);
			$label_from = $label_to = date('d-m-Y');
			$filename   = 'laporan_pembelian_'.date('Ymd').'.xlsx';
		}

		$sheet = $this->build_purchase_sheet($report, 'Laporan Pembelian', $label_from, $label_to);
		$sheet['name'] = 'Pembelian';

		$CI->excel_export->download($filename, array($sheet));
	}

	/**
	 * Laporan penjualan per produk. Tanpa tanggal akan mengunduh seluruh
	 * data (bukan hanya satu halaman paginasi seperti di layar).
	 */
	public function product_sales_report_excel()
	{
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		if (!$this->permission1->method('sales_report_medicine_wise','read')->access()) {
			$this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
			redirect('Admin_dashboard/product_sales_reports_date_wise');
		}
		$CI->load->library('excel_export');
		$CI->load->library('occational');
		$CI->load->model('Reports');

		$from_date = $this->input->get('from_date');
		$to_date   = $this->input->get('to_date');

		if ($from_date && $to_date) {
			$report = $CI->Reports->retrieve_product_search_sales_report($from_date, $to_date);
			$label_from = $from_date;
			$label_to   = $to_date;
			$filename   = 'laporan_penjualan_produk_'.date('Ymd', strtotime($from_date)).'_'.date('Ymd', strtotime($to_date)).'.xlsx';
		} else {
			// Ambil semua baris, bukan hanya halaman yang sedang tampil.
			$total  = $CI->Reports->retrieve_product_sales_report_count();
			$report = $CI->Reports->retrieve_product_sales_report(($total > 0 ? $total : 1), 0);
			$label_from = $label_to = '';
			$filename   = 'laporan_penjualan_produk_'.date('Ymd').'.xlsx';
		}

		$rows  = array();
		$total_amount = 0;
		if (!empty($report)) {
			foreach ($report as $row) {
				$total_amount += $row['total_price'];
				$rows[] = array(
					$CI->occational->dateConvert($row['date']),
					$row['product_name'],
					$row['product_model'],
					$row['customer_name'],
					$CI->Reports->payment_type_label($row),
					$row['quantity'],
					$row['rate'],
					$row['total_price'],
				);
			}
		}

		$CI->excel_export->download($filename, array(array(
			'name'   => 'Penjualan Produk',
			'title'  => $this->excel_title('Laporan Penjualan Per Produk', $label_from, $label_to),
			'header' => array('Tanggal','Nama Produk','Model Produk','Pelanggan','Jenis Pembayaran','Jumlah','Harga','Total'),
			'rows'   => $rows,
			'number' => array(5),
			'money'  => array(6, 7),
			// Label "Total" ditaruh di kolom non-uang, sebab kolom uang selalu
			// ditulis sebagai angka sehingga teks di sana berubah jadi 0.
			'footer' => array('','','','','Total','','', $total_amount),
		)));
	}

	/**
	 * Rakit satu sheet penjualan dari hasil query invoice.
	 *
	 * @param array|false $report
	 * @param string      $heading
	 * @param string      $from
	 * @param string      $to
	 * @return array
	 */
	private function build_sales_sheet($report, $heading, $from, $to)
	{
		$CI =& get_instance();
		$CI->load->library('occational');
		$CI->load->model('Reports');

		$rows  = array();
		$total = 0;
		if (!empty($report)) {
			foreach ($report as $row) {
				$total += $row['total_amount'];
				$rows[] = array(
					$CI->occational->dateConvert($row['date']),
					(!empty($row['invoice']) ? $row['invoice'] : $row['invoice_id']),
					$row['customer_name'],
					$CI->Reports->payment_type_label($row),
					$row['total_amount'],
				);
			}
		}

		return array(
			'title'  => $this->excel_title($heading, $from, $to),
			'header' => array('Tanggal','No Faktur','Nama Pelanggan','Jenis Pembayaran','Total'),
			'rows'   => $rows,
			'money'  => array(4),
			'footer' => array('','','','Total Penjualan', $total),
		);
	}

	/**
	 * Rakit satu sheet pembelian dari hasil query product_purchase.
	 *
	 * @param array|false $report
	 * @param string      $heading
	 * @param string      $from
	 * @param string      $to
	 * @return array
	 */
	private function build_purchase_sheet($report, $heading, $from, $to)
	{
		$CI =& get_instance();
		$CI->load->library('occational');
		$CI->load->model('Reports');

		$rows  = array();
		$total = 0;
		if (!empty($report)) {
			foreach ($report as $row) {
				$total += $row['grand_total_amount'];
				$rows[] = array(
					$CI->occational->dateConvert($row['purchase_date']),
					$row['chalan_no'],
					$row['manufacturer_name'],
					$CI->Reports->purchase_payment_type_label($row),
					$row['grand_total_amount'],
				);
			}
		}

		return array(
			'title'  => $this->excel_title($heading, $from, $to),
			'header' => array('Tanggal','No Faktur','Nama Distributor','Jenis Pembayaran','Total'),
			'rows'   => $rows,
			'money'  => array(4),
			'footer' => array('','','','Total Pembelian', $total),
		);
	}

	/**
	 * Baris judul di atas tabel: nama apotek, judul laporan, periode,
	 * dan waktu cetak.
	 *
	 * @param string $heading
	 * @param string $from
	 * @param string $to
	 * @return array
	 */
	private function excel_title($heading, $from, $to)
	{
		$CI =& get_instance();
		$CI->load->model('Reports');

		$titles  = array();
		$company = $CI->Reports->retrieve_company();
		if (!empty($company[0]['company_name'])) {
			$titles[] = $company[0]['company_name'];
		}
		$titles[] = $heading;
		if ($from && $to) {
			$titles[] = 'Periode: '.$from.' s/d '.$to;
		}
		$titles[] = 'Waktu Cetak: '.date('d/m/Y H:i:s');

		return $titles;
	}

	#============User login=========#
	public function login()
	{	
		if ($this->auth->is_logged() )
		{
			$this->output->set_header("Location: ".base_url().'Admin_dashboard', TRUE, 302);
		}
		$data['title'] = display('admin_login_area');
        $content = $this->parser->parse('user/admin_login_form',$data,true);
		$this->template->full_admin_html_view($content);
	}
	#==============Valid user check=======#
	public function do_login(){

		$error = '';
		$setting_detail = $this->Web_settings->retrieve_setting_editdata(); 

		if ($setting_detail[0]['captcha'] == 0 && $setting_detail[0]['secret_key'] != null && $setting_detail[0]['site_key'] != null) {

			$this->form_validation->set_rules('g-recaptcha-response', 'recaptcha validation', 'required|callback_validate_captcha');
			$this->form_validation->set_message('validate_captcha', 'Please check the the captcha form');

			if ($this->form_validation->run() == FALSE){
				$this->session->set_userdata(array('error_message'=>display('please_enter_valid_captcha')));
				$this->output->set_header("Location: ".base_url().'Admin_dashboard/login', TRUE, 302);
			}
			else{
				$username = $this->input->post('username',true);
				$password = $this->input->post('password',true);
				if ( $username == '' || $password == '' || $this->auth->login($username, $password) === FALSE ){
					$error = display('wrong_username_or_password');
				}
				if ( $error != '' ){
					$this->session->set_userdata(array('error_message'=>$error));
					$this->output->set_header("Location: ".base_url().'Admin_dashboard/login', TRUE, 302);
				}
				else{
					$this->output->set_header("Location: ".base_url(), TRUE, 302);
		        }
			}
		}
		else{
			$username = $this->input->post('username',true);
			$password = $this->input->post('password',true);
			if ( $username == '' || $password == '' || $this->auth->login($username, $password) === FALSE ){
				$error = display('wrong_username_or_password');
			}
			if ( $error != '' ){
				$this->session->set_userdata(array('error_message'=>$error));
				$this->output->set_header("Location: ".base_url().'Admin_dashboard/login', TRUE, 302);
			}else{
				$this->output->set_header("Location: ".base_url(), TRUE, 302);
	        }
		}
	}

	//Valid captcha check
	function validate_captcha() { 
	  	$captcha = $this->input->post('g-recaptcha-response'); 
		$url = "www.google.com/recaptcha/api/siteverify?secret=6LdiKhsUAAAAABH4BQCIvBar7Oqe-2LwDKxMSX-t&response=" . $captcha . "&remoteip=" . $_SERVER['REMOTE_ADDR'];
		$ch = curl_init();
		curl_setopt ($ch, CURLOPT_URL, $url);
		curl_setopt ($ch, CURLOPT_CONNECTTIMEOUT, 5);
		curl_setopt ($ch, CURLOPT_RETURNTRANSFER, true);
		$contents = curl_exec($ch);
		if (curl_errno($ch)) {
		  echo curl_error($ch);
		  echo "\n<br />";
		  $contents = '';
		} else {
		  curl_close($ch);
		}
	 	if ($contents . 'success' == false) { return FALSE; } else { return TRUE; } 
	}

	#===============Logout=======#
	public function logout()
	{	
		if ($this->auth->logout())
		$this->output->set_header("Location: ".base_url().'Admin_dashboard/login', TRUE, 302);
	}
	#=============Edit Profile======#
	public function edit_profile()
	{	
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		$CI->load->library('luser');
		$content = $CI->luser->edit_profile_form();
		$this->template->full_admin_html_view($content);
	}
	#=============Update Profile========#
	public function update_profile()
	{	
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		$CI->load->model('Users');
		$this->Users->profile_update();
		$this->session->set_userdata(array('message'=> display('successfully_updated')));
		redirect(base_url('Admin_dashboard/edit_profile'));
	}
	#=============Change Password=========# 
	public function change_password_form()
	{	
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		$content = $CI->parser->parse('user/change_password',array('title'=>display('change_password')),true);
		$this->template->full_admin_html_view($content);
	}
	#============Change Password===========#
	public function change_password()
	{	
		$CI =& get_instance();
		$this->auth->check_admin_auth();
		$CI->load->model('Users'); 

		$error = '';
		$email = $this->input->post('email',true);
		$old_password = $this->input->post('old_password',true);
		$new_password = $this->input->post('password',true);
		$repassword = $this->input->post('repassword',true);
		if ( $email == '' || $old_password == '' || $new_password == '')
		{
			$error = display('blank_field_does_not_accept');
		}else if($email != $this->session->userdata('user_email')){
			$error = display('you_put_wrong_email_address');
		}else if(strlen($new_password)<6 ){
			$error = display('new_password_at_least_six_character');
		}else if($new_password != $repassword ){
			$error = display('password_and_repassword_does_not_match');
		}else if($CI->Users->change_password($email,$old_password,$new_password) === FALSE ){
			$error = display('you_are_not_authorised_person');
		}
		if ( $error != '' )
		{
			$this->session->set_userdata(array('error_message'=>$error));
			$this->output->set_header("Location: ".base_url().'Admin_dashboard/change_password_form', TRUE, 302);
		}else{
			$this->session->set_userdata(array('message'=>display('successfully_changed_password')));
			$this->output->set_header("Location: ".base_url().'Admin_dashboard/change_password_form', TRUE, 302);
        }
	}
	 public function profit_manufacturer_form(){
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        $CI->load->library('lreport');
        $content = $CI->lreport->profit_report_manufacturer_form();
        $this->template->full_admin_html_view($content);
        

    } 


    public function closing() {
        $CI = & get_instance();
        $CI->load->model('Reports');
        $data = array('title' => "Reports | Daily Closing");
        $data = $this->Reports->accounts_closing_data();
        $content = $this->parser->parse('accounts/closing_form', $data, true);
        $this->template->full_admin_html_view($content);
    }

      //Closing report
    public function closing_report()
    {
        $CI = & get_instance();
        $CI->load->library('laccounts');
        $content =$this->laccounts->daily_closing_list();
        $this->template->full_admin_html_view($content);
    }
    // Date wise closing reports 
    public function date_wise_closing_reports()
    {    
        $CI = & get_instance();
        $CI->load->library('laccounts');
         $CI->load->model('Accounts');
        $from_date = $this->input->get('from_date');       
        $to_date = $this->input->get('to_date');
        #
        #pagination starts
        #
        $config["base_url"]     = base_url('Admin_dashboard/date_wise_closing_reports/');
        $config["total_rows"]   = $this->Accounts->get_date_wise_closing_report_count($from_date,$to_date);
        $config["per_page"] = 50;
        $config["uri_segment"] = 3;
        $config["num_links"] = 5; 
        $config['suffix'] = '?'. http_build_query($_GET, '', '&');
        $config['first_url'] = $config["base_url"] . $config['suffix'];
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
        /* ends of bootstrap */
        $this->pagination->initialize($config);
        $page = ($this->uri->segment(3)) ? $this->uri->segment(3) : 0;
        $links = $this->pagination->create_links();
        #
        #pagination ends
        # 
        
        $content = $this->laccounts->get_date_wise_closing_reports($links,$config["per_page"],$page,$from_date,$to_date );
       
        $this->template->full_admin_html_view($content);
    }
	// profit report manufacturer wise
        public function profit_manufacturer(){
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        $CI->load->library('lreport');
        $manufacturer_id = $this->input->post('manufacturer_id',true);
        $from_date       = $this->input->post('from_date',true);
        $to_date         = $this->input->post('to_date',true);
        $content = $CI->lreport->profit_report_manufacturer($manufacturer_id,$from_date,$to_date);
        $this->template->full_admin_html_view($content);


    }

    /**
     * Unduh laporan Distributor Wise: satu baris per tanggal per
     * distributor, mengikuti rentang tanggal dan pilihan distributor
     * yang sedang dilihat di layar.
     */
    public function profit_manufacturer_excel(){
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        if (!$this->permission1->method('profit_loss','read')->access()) {
            $this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
            redirect('Admin_dashboard/profit_manufacturer_form');
        }
        $CI->load->library('excel_export');
        $CI->load->model('Reports');
        $CI->load->model('manufacturers');

        $manufacturer_id = $this->input->get('manufacturer_id');
        $from_date       = (!empty($this->input->get('from_date'))?$this->input->get('from_date'):date('Y-m-d'));
        $to_date         = (!empty($this->input->get('to_date'))?$this->input->get('to_date'):date('Y-m-d'));

        $report = $CI->Reports->profit_manufacturer_datewise($from_date,$to_date,$manufacturer_id);

        $rows       = array();
        $total_sell = 0;
        $total_cost = 0;
        $total_gm   = 0;

        foreach ($report as $row) {
            $total_sell += $row['total_sell'];
            $total_cost += $row['total_cost'];
            $total_gm   += $row['gross_margin'];

            $rows[] = array(
                $row['date'],
                $row['manufacturer_name'],
                $row['total_sell'],
                $row['total_cost'],
                $row['gross_margin'],
            );
        }

        // Kalau difilter ke satu distributor, namanya ikut ditulis di judul.
        $heading = 'Laporan Distributor Wise';
        if (!empty($manufacturer_id)) {
            $info = $CI->manufacturers->retrieve_manufacturer_editdata($manufacturer_id);
            if (!empty($info[0]['manufacturer_name'])) {
                $heading .= ' - '.$info[0]['manufacturer_name'];
            }
        }

        $CI->excel_export->download(
            'laporan_distributor_wise_'.date('Ymd', strtotime($from_date)).'_'.date('Ymd', strtotime($to_date)).'.xlsx',
            array(array(
                'name'   => 'Distributor Wise',
                'title'  => $this->excel_title($heading, $from_date, $to_date),
                'header' => array('Tanggal','Nama Distributor','Total Sell Price','Total Purchase Price','Gross Margin'),
                'rows'   => $rows,
                'money'  => array(2, 3, 4),
                'footer' => array('','Total', $total_sell, $total_cost, $total_gm),
            ))
        );
    }
// product wise profit report form
     public function profit_productwise_form(){
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        $CI->load->library('lreport');
        $content = $CI->lreport->profit_productwise_form();
        $this->template->full_admin_html_view($content);
        

    } 
    
    
    public function profit_loss_salepurchase(){
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        $CI->load->library('lreport');
        $from_date = (!empty($this->input->post('from_date',true))?$this->input->post('from_date',true):date('Y-m-d'));
        $to_date   = (!empty($this->input->post('to_date',true))?$this->input->post('to_date',true):date('Y-m-d'));
        $content = $CI->lreport->profit_loss_salepurchase($from_date,$to_date);
        $this->template->full_admin_html_view($content);
        

    }
	// profit report manufacturer wise
       public function profit_productwise(){
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        $CI->load->library('lreport');
        $product_id = $this->input->post('product_id',true);
        $from_date  = $this->input->post('from_date',true);
        $to_date    = $this->input->post('to_date',true);
        $content    = $CI->lreport->profit_productwise($product_id,$from_date,$to_date);
        $this->template->full_admin_html_view($content);


    }

    /**
     * Unduh laporan Obat Wise: satu baris per tanggal per obat, mengikuti
     * rentang tanggal dan pilihan obat yang sedang dilihat di layar.
     */
    public function profit_productwise_excel(){
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        if (!$this->permission1->method('profit_loss','read')->access()) {
            $this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
            redirect('Admin_dashboard/profit_productwise_form');
        }
        $CI->load->library('excel_export');
        $CI->load->model('Reports');
        $CI->load->model('Products');

        $product_id = $this->input->get('product_id');
        $from_date  = (!empty($this->input->get('from_date'))?$this->input->get('from_date'):date('Y-m-d'));
        $to_date    = (!empty($this->input->get('to_date'))?$this->input->get('to_date'):date('Y-m-d'));

        $report = $CI->Reports->profit_productwise_datewise($from_date,$to_date,$product_id);

        $rows       = array();
        $total_qty  = 0;
        $total_sell = 0;
        $total_cost = 0;
        $total_gm   = 0;

        foreach ($report as $row) {
            $total_qty  += $row['total_qty'];
            $total_sell += $row['total_sell'];
            $total_cost += $row['total_cost'];
            $total_gm   += $row['gross_margin'];

            $rows[] = array(
                $row['date'],
                $row['product_name'],
                $row['total_qty'],
                $row['unit'],
                $row['manufacturer_name'],
                $row['total_sell'],
                $row['total_cost'],
                $row['gross_margin'],
            );
        }

        // Kalau difilter ke satu obat, namanya ikut ditulis di judul.
        $heading = 'Laporan Obat Wise';
        if (!empty($product_id)) {
            $info = $CI->Products->retrieve_product_editdata($product_id);
            if (!empty($info[0]['product_name'])) {
                $heading .= ' - '.$info[0]['product_name'];
            }
        }

        $CI->excel_export->download(
            'laporan_obat_wise_'.date('Ymd', strtotime($from_date)).'_'.date('Ymd', strtotime($to_date)).'.xlsx',
            array(array(
                'name'   => 'Obat Wise',
                'title'  => $this->excel_title($heading, $from_date, $to_date),
                'header' => array('Tanggal','Nama Obat','Jumlah Obat','Satuan','Nama Distributor','Total Sell Price','Total Purchase Price','Gross Margin'),
                'rows'   => $rows,
                'number' => array(2),
                'money'  => array(5, 6, 7),
                'footer' => array('','Total', $total_qty, '', '', $total_sell, $total_cost, $total_gm),
            ))
        );
    }
    
    public function daily_profit(){
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        $CI->load->library('lreport');
        $from_date = (!empty($this->input->post('from_date',true))?$this->input->post('from_date',true):date('Y-m-d'));
        $to_date  = (!empty($this->input->post('to_date',true))?$this->input->post('to_date',true):date('Y-m-d'));
        $content  = $CI->lreport->daily_profit($from_date,$to_date);
        $this->template->full_admin_html_view($content);
    }

    /**
     * Unduh laporan Invoice Wise sesuai rentang tanggal yang sedang dilihat.
     * Isi dan urutan kolomnya sama persis dengan tabel di layar.
     */
    public function daily_profit_excel(){
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        if (!$this->permission1->method('profit_loss','read')->access()) {
            $this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
            redirect('Admin_dashboard/daily_profit');
        }
        $CI->load->library('excel_export');
        $CI->load->model('Reports');

        $from_date = (!empty($this->input->get('from_date'))?$this->input->get('from_date'):date('Y-m-d'));
        $to_date   = (!empty($this->input->get('to_date'))?$this->input->get('to_date'):date('Y-m-d'));

        $salepurchase = $CI->Reports->profitloss_days($from_date,$to_date);
        $invoice_map  = $CI->Reports->invoice_cost_distributor_map($from_date,$to_date);

        $rows         = array();
        $total_sale   = 0;
        $total_mprice = 0;
        $total_profit = 0;

        if (!empty($salepurchase)) {
            foreach ($salepurchase as $result) {
                $info   = (isset($invoice_map[$result['invoice_id']])
                            ? $invoice_map[$result['invoice_id']]
                            : array('cost' => 0, 'distributor' => '-'));
                $cost   = $info['cost'];
                $profit = $result['total_amount'] - $cost;

                $total_sale   += $result['total_amount'];
                $total_mprice += $cost;
                $total_profit += $profit;

                $rows[] = array(
                    $result['date'],
                    $result['invoice'],
                    $info['distributor'],
                    (float) $result['total_amount'],
                    (float) $cost,
                    (float) $profit,
                );
            }
        }

        $CI->excel_export->download(
            'laporan_invoice_wise_'.date('Ymd', strtotime($from_date)).'_'.date('Ymd', strtotime($to_date)).'.xlsx',
            array(array(
                'name'   => 'Invoice Wise',
                'title'  => $this->excel_title('Laporan Invoice Wise', $from_date, $to_date),
                'header' => array('Tanggal','No Faktur','Nama Distributor','Total Harga Jual','Total Harga Beli','Gross Margin'),
                'rows'   => $rows,
                'money'  => array(3, 4, 5),
                'footer' => array('','','Total', $total_sale, $total_mprice, $total_profit),
            ))
        );
    }
}