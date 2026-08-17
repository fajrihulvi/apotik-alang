<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Cstock_opname extends CI_Controller {

	function __construct() {
		parent::__construct();
		$this->load->library('auth');
		$this->load->library('lstock_opname');
		$this->load->library('session');
		$this->load->library('occational');
		$this->load->model('Stock_opname');
		$this->auth->check_admin_auth();
	}

	// Daftar sesi opname
	public function index()
	{
		if (!$this->permission1->method('opname_list','read')->access()) {
			$this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
			redirect('Admin_dashboard');
		}
		$content = $this->lstock_opname->opname_list();
		$this->template->full_admin_html_view($content);
	}

	// Form input opname baru
	public function opname_form()
	{
		if (!$this->permission1->method('add_stock_opname','create')->access()) {
			$this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
			redirect('Admin_dashboard');
		}
		$content = $this->lstock_opname->opname_form();
		$this->template->full_admin_html_view($content);
	}

	// AJAX: cari produk beserta stok sistem terkini
	public function search_product()
	{
		$keyword      = $this->input->get('keyword', true);
		$manufacturer = $this->input->get('manufacturer_id', true);
		$rows = $this->Stock_opname->product_for_opname($keyword, $manufacturer, 100);

		header('Content-Type: application/json');
		echo json_encode($rows);
	}

	// Simpan sebagai draft
	public function save_draft()
	{
		if (!$this->permission1->method('add_stock_opname','create')->access()) {
			$this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
			redirect('Admin_dashboard');
		}

		$opname_id = $this->Stock_opname->save_opname(false);

		if ($opname_id) {
			$this->session->set_userdata(array('message'=>display('save_successfully')));
			redirect('Cstock_opname/opname_details/'.$opname_id);
		}
		$this->session->set_userdata(array('error_message'=>display('please_try_again')));
		redirect('Cstock_opname/opname_form');
	}

	// Simpan sekaligus posting
	public function save_and_post()
	{
		if (!$this->permission1->method('add_stock_opname','create')->access()) {
			$this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
			redirect('Admin_dashboard');
		}

		$opname_id = $this->Stock_opname->save_opname(true);

		if ($opname_id) {
			$this->session->set_userdata(array('message'=>display('save_successfully')));
			redirect('Cstock_opname/opname_details/'.$opname_id);
		}
		$this->session->set_userdata(array('error_message'=>display('please_try_again')));
		redirect('Cstock_opname/opname_form');
	}

	// Detail satu sesi opname
	public function opname_details($opname_id = null)
	{
		if (!$this->permission1->method('opname_list','read')->access()) {
			$this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
			redirect('Admin_dashboard');
		}
		if (empty($opname_id)) {
			redirect('Cstock_opname');
		}
		$content = $this->lstock_opname->opname_details($opname_id);
		$this->template->full_admin_html_view($content);
	}

	// Posting draft -> permanen
	public function post_opname($opname_id = null)
	{
		if (!$this->permission1->method('opname_list','update')->access()) {
			$this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
			redirect('Admin_dashboard');
		}

		if ($opname_id && $this->Stock_opname->post_opname($opname_id)) {
			$this->session->set_userdata(array('message'=>display('update_successfully')));
		} else {
			$this->session->set_userdata(array('error_message'=>display('please_try_again')));
		}
		redirect('Cstock_opname/opname_details/'.$opname_id);
	}

	// Hapus draft (yang sudah diposting tidak bisa dihapus)
	public function delete_draft($opname_id = null)
	{
		if (!$this->permission1->method('opname_list','delete')->access()) {
			$this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
			redirect('Admin_dashboard');
		}

		if ($opname_id && $this->Stock_opname->delete_draft($opname_id)) {
			$this->session->set_userdata(array('message'=>display('delete_successfully')));
		} else {
			$this->session->set_userdata(array('error_message'=>display('please_try_again')));
		}
		redirect('Cstock_opname');
	}

	// Laporan log audit
	public function opname_log()
	{
		if (!$this->permission1->method('opname_log','read')->access()) {
			$this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
			redirect('Admin_dashboard');
		}
		$content = $this->lstock_opname->opname_log();
		$this->template->full_admin_html_view($content);
	}

	// Ekspor log ke CSV
	public function export_log_csv()
	{
		if (!$this->permission1->method('opname_log','read')->access()) {
			$this->session->set_userdata(array('error_message'=>display('you_are_not_access_this_part')));
			redirect('Admin_dashboard');
		}

		$filter = array(
			'from_date'   => $this->input->get('from_date', true),
			'to_date'     => $this->input->get('to_date', true),
			'user_id'     => $this->input->get('user_id', true),
			'reason_code' => $this->input->get('reason_code', true),
		);
		$rows = $this->Stock_opname->get_opname_log($filter);

		$filename = 'log_stock_opname_'.date('Ymd_His').'.csv';
		header("Content-Description: File Transfer");
		header("Content-Disposition: attachment; filename=$filename");
		header("Content-Type: text/csv; charset=utf-8");

		$file = fopen('php://output', 'w');
		// BOM supaya Excel membaca UTF-8 dengan benar
		fprintf($file, chr(0xEF).chr(0xBB).chr(0xBF));

		fputcsv($file, array(
			'Tanggal','Jam','No. Opname','Nama Obat','Satuan',
			'Stok Sebelum','Stok Sesudah','Selisih','Alasan','Keterangan','User','Status'
		));

		foreach ($rows as $r) {
			fputcsv($file, array(
				$r['tanggal'],
				$r['jam'],
				$r['no_opname'],
				trim($r['nama_produk'].' '.$r['kekuatan']),
				$r['satuan'],
				$r['stok_sebelum'],
				$r['stok_sesudah'],
				$r['selisih'],
				display('reason_'.$r['kode_alasan']),
				$r['keterangan'],
				trim($r['nama_user']),
				($r['status_opname'] == 1 ? display('opname_posted') : display('opname_draft')),
			));
		}
		fclose($file);
		exit;
	}
}
