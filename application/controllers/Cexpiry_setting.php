<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Cexpiry_setting extends CI_Controller {

	function __construct() {
		parent::__construct();
		$this->load->library('auth');
		$this->load->model('Web_settings');
		// Wajib login. Kontrol akses granular dilakukan lewat RBAC (permission1)
		// pada module 'expiry_alert_setting' -> menu & aksi hanya untuk role yang diberi izin.
		if (!$this->auth->is_logged()) {
			redirect(base_url('Admin_dashboard/login'));
		}
	}

	/**
	 * Tampilkan form pengaturan Ambang Notifikasi Kedaluwarsa (1 field).
	 */
	public function index() {
		// blokir jika role tidak punya izin baca module ini
		$this->permission1->method('expiry_alert_setting', 'read')->redirect();

		$data['title']   = display('expiry_alert_setting');
		$data['setting'] = $this->Web_settings->retrieve_setting_editdata();
		$content = $this->parser->parse('expiry_setting/expiry_alert_form', $data, true);
		$this->template->full_admin_html_view($content);
	}

	/**
	 * Simpan ambang notifikasi (bulan). Update kolom yang sama dg Web Setting.
	 */
	public function update_expiry_alert() {
		$this->permission1->method('expiry_alert_setting', 'update')->redirect();

		$months = (int) $this->input->post('expiry_alert_months', true);
		$data = array(
			'expiry_alert_months' => ($months > 0 ? $months : 8),
		);

		if ($this->Web_settings->update_setting($data)) {
			$this->session->set_flashdata('message', display('successfully_updated'));
		} else {
			$this->session->set_flashdata('error_message', display('please_try_again'));
		}
		redirect('Cexpiry_setting');
	}
}
