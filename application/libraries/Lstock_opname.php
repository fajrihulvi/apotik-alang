<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Presenter Stock Opname, mengikuti pola library L* yang sudah dipakai
 * di seluruh proyek ini.
 */
class Lstock_opname {

	// Form input opname baru
	public function opname_form()
	{
		$CI =& get_instance();
		$CI->load->model('Stock_opname');

		$data['opname_no']     = $CI->Stock_opname->generate_opname_no();
		$data['opname_date']   = date('d-m-Y');
		$data['opname_time']   = date('H:i');
		$data['reason_list']   = $CI->Stock_opname->reason_list();
		$data['manufacturers'] = $CI->db->select('manufacturer_id,manufacturer_name')
										->from('manufacturer_information')
										->order_by('manufacturer_name','asc')
										->get()->result_array();

		return $CI->load->view('stock_opname/opname_form', $data, true);
	}

	// Daftar sesi opname
	public function opname_list()
	{
		$CI =& get_instance();
		$CI->load->model('Stock_opname');
		$CI->load->library('occational');

		$rows = $CI->Stock_opname->opname_list();
		foreach ($rows as $k => $v) {
			$rows[$k]['tanggal_tampil'] = $CI->occational->dateConvert($v['opname_date']);
		}

		$data['opname_list'] = $rows;
		return $CI->load->view('stock_opname/opname_list', $data, true);
	}

	// Detail satu sesi opname
	public function opname_details($opname_id)
	{
		$CI =& get_instance();
		$CI->load->model('Stock_opname');
		$CI->load->library('occational');

		$header = $CI->Stock_opname->opname_header($opname_id);
		if (empty($header)) {
			redirect('Cstock_opname');
		}
		$header['tanggal_tampil'] = $CI->occational->dateConvert($header['opname_date']);

		$data['header']      = $header;
		$data['details']     = $CI->Stock_opname->opname_details($opname_id);
		$data['reason_list'] = $CI->Stock_opname->reason_list();

		return $CI->load->view('stock_opname/opname_details', $data, true);
	}

	// Laporan log audit
	public function opname_log()
	{
		$CI =& get_instance();
		$CI->load->model('Stock_opname');
		$CI->load->library('occational');

		$filter = array(
			'from_date'   => $CI->input->get('from_date', true),
			'to_date'     => $CI->input->get('to_date', true),
			'user_id'     => $CI->input->get('user_id', true),
			'reason_code' => $CI->input->get('reason_code', true),
		);

		$rows = $CI->Stock_opname->get_opname_log($filter);
		foreach ($rows as $k => $v) {
			$rows[$k]['tanggal_tampil'] = $CI->occational->dateConvert($v['tanggal']);
		}

		$data['log']         = $rows;
		$data['filter']      = $filter;
		$data['reason_list'] = $CI->Stock_opname->reason_list();
		$data['user_list']   = $CI->Stock_opname->log_user_list();

		return $CI->load->view('stock_opname/opname_log', $data, true);
	}
}
