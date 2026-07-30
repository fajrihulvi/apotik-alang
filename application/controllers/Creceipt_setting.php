<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Creceipt_setting extends CI_Controller {

	function __construct() {
		parent::__construct();
		$this->load->library('auth');
		$this->load->model('Web_settings');
		$this->auth->check_admin_auth();
	}

	/**
	 * Tampilkan form kelola Header & Footer struk.
	 */
	public function index() {
		$this->auth->check_admin_auth();
		$data['title']   = display('receipt_header_footer');
		$data['setting'] = $this->Web_settings->retrieve_setting_editdata();
		$content = $this->parser->parse('receipt_setting/header_footer_form', $data, true);
		$this->template->full_admin_html_view($content);
	}

	/**
	 * Simpan Header & Footer struk.
	 * Nilai berupa HTML dari Summernote -> disimpan apa adanya (post arg xss = false),
	 * karena hanya superadmin/owner yang mengelola.
	 */
	public function update_header_footer() {
		$this->auth->check_admin_auth();

		$data = array(
			'receipt_header' => $this->input->post('receipt_header', false),
			'receipt_footer' => $this->input->post('receipt_footer', false),
		);

		if ($this->Web_settings->update_setting($data)) {
			$this->session->set_flashdata('message', display('successfully_updated'));
		} else {
			$this->session->set_flashdata('error_message', display('please_try_again'));
		}
		redirect('Creceipt_setting');
	}
}
