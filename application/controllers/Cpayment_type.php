<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Cpayment_type extends CI_Controller {

	function __construct() {
		parent::__construct();
		$this->load->library('auth');
		$this->load->model('Payment_type_model');
		$this->auth->check_admin_auth();
	}

	/**
	 * Add (create) + Edit (update) form handler.
	 * Follows the same pattern as Cproduct::unit_form().
	 */
	public function payment_type_form($id = null) {
		$this->auth->check_admin_auth();
		$this->load->library('form_validation');

		/*----------FORM VALIDATION RULES----------*/
		$this->form_validation->set_rules('payment_type_name', display('payment_type_name'), 'required|max_length[255]');
		$this->form_validation->set_rules('status', display('status'), 'required');

		$data['payment_type'] = (object) $postData = array(
			'id'                => $this->input->post('id', true),
			'payment_type_name' => $this->input->post('payment_type_name', true),
			'status'            => $this->input->post('status', true),
		);

		/*-----------CHECK ID -----------*/
		if (empty($id)) {
			/*-----------CREATE A NEW RECORD-----------*/
			if ($this->form_validation->run() === true) {
				unset($postData['id']);
				if ($this->Payment_type_model->create($postData)) {
					$this->session->set_flashdata('message', display('save_successfully'));
				} else {
					$this->session->set_flashdata('error_message', display('please_try_again'));
				}
				redirect('Cpayment_type/payment_type_form');
			} else {
				$data['title'] = display('add_payment_type');
				$content = $this->parser->parse('payment_type/payment_type_form', $data, true);
				$this->template->full_admin_html_view($content);
			}
		} else {
			/*-----------UPDATE A RECORD-----------*/
			if ($this->form_validation->run() === true) {
				if ($this->Payment_type_model->update($postData)) {
					$this->session->set_flashdata('message', display('successfully_updated'));
				} else {
					$this->session->set_flashdata('error_message', display('please_try_again'));
				}
				redirect('Cpayment_type/payment_type_form/'.$postData['id']);
			} else {
				$data['title'] = display('edit_payment_type');
				$data['payment_type'] = $this->Payment_type_model->read_by_id($id);
				$content = $this->parser->parse('payment_type/edit_payment_type', $data, true);
				$this->template->full_admin_html_view($content);
			}
		}
	}

	/**
	 * List all payment types.
	 */
	public function payment_type_list() {
		$this->auth->check_admin_auth();
		$data['title'] = display('payment_type_list');
		$data['payment_type'] = $this->Payment_type_model->read();
		$content = $this->parser->parse('payment_type/payment_type_list', $data, true);
		$this->template->full_admin_html_view($content);
	}

	/**
	 * Delete a payment type.
	 */
	public function delete_payment_type($id = null) {
		$this->auth->check_admin_auth();
		if ($this->Payment_type_model->delete($id)) {
			$this->session->set_flashdata('message', display('delete_successfully'));
		} else {
			$this->session->set_flashdata('error_message', display('please_try_again'));
		}
		redirect('Cpayment_type/payment_type_list');
	}
}
