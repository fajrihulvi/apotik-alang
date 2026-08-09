<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Cretrun_m extends CI_Controller {
    public $menu;
    function __construct() {
      parent::__construct();
        $this->load->library('auth');
        $this->load->library('lreturn');
        $this->load->library('linvoice');
        $this->load->library('session');
        $this->auth->check_admin_auth();
    }
    public function index(){


        $content = $this->lreturn->return_form();
    
        $this->template->full_admin_html_view($content);
    }
    // invoice return form
    public function invoice_return_form()
    {   $invoice_no=$this->input->post('invoice_no',true);
       $query = $this->db->select('invoice')->from('invoice')->where('invoice',$invoice_no)->get();
    

        if ($query->num_rows() == 0) {
             $this->session->set_userdata(array('error_message'=>display('please_input_correct_invoice_no')));
               redirect('Cretrun_m');
        }
        $CI =& get_instance();
        $CI->auth->check_admin_auth();
        $CI->load->library('lreturn');
        $content = $CI->lreturn->invoice_return_data($invoice_no);
        $this->template->full_admin_html_view($content);
    }
// manufacturer return form
     public function manufacturer_return_form()
    {  
        $CI =& get_instance();
        $CI->auth->check_admin_auth();
        $CI->load->library('lreturn');
        $CI->load->model('Returnse');
        $purchase_id = trim($this->input->post('purchase_id',true));
        $check_id = $CI->Returnse->check_purchase_id($purchase_id);
        if($check_id == 0){
         $this->session->set_userdata(array('error_message'=> 'Please Input Valid Purchase Id'));
               redirect('Cretrun_m');    
        }
        $content = $CI->lreturn->manufacturer_return_data($purchase_id);
        $this->template->full_admin_html_view($content);
    }
    public function return_invoice()
    {
        $CI =& get_instance();
        $CI->auth->check_admin_auth();
        $CI->load->model('Returnse');
        $ret_id = $CI->Returnse->return_invoice_entry();
        $this->session->set_userdata(array('message'=>display('successfully_added')));
        $this->invoice_inserted_data($ret_id);

    }
    // return manufacturer insert  start
    public function return_manufacturers()
    {
        $CI =& get_instance();
        $CI->auth->check_admin_auth();
        $CI->load->model('Returnse');
        $ret_id = $CI->Returnse->return_manufacturer_entry();
        $this->session->set_userdata(array('message'=>display('successfully_added')));
        $this->manufacturer_inserted_data($ret_id);

    }
    // manufacturer inserted  data
    public function manufacturer_inserted_data($ret_id)
    {   
        $CI =& get_instance();
        $CI->auth->check_admin_auth();
        $CI->load->library('lreturn');
        $content = $CI->lreturn->manufacturer_html_data($ret_id);        
        $this->template->full_admin_html_view($content);
    }
    // return list start
    public function return_list()
    {   
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        $CI->load->library('lreturn');
        $CI->load->model('Returnse');

        #
        #pagination starts
        #
        $config["base_url"] = base_url('Cretrun_m/return_list/');
        $config["total_rows"] = $this->Returnse->return_list_count();
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
        $content =$this->lreturn->return_list($links,$config["per_page"],$page);
        $this->template->full_admin_html_view($content);
    }

// date between return report list
    public function datewise_invoic_return_list(){
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        $CI->load->library('lreturn');
        $CI->load->model('Returnse');
         $config["base_url"] = base_url('Cretrun_m/return_list/');
        $config["total_rows"] = $this->Returnse->return_list_count();
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
        $from_date = $this->input->post('from_date',true);       
        $to_date = $this->input->post('to_date',true);
        $content = $CI->lreturn->return_list_datebetween($from_date,$to_date,$links,$config["per_page"],$page);
        $this->template->full_admin_html_view($content);
    }
    public function manufacturer_return_list()
    {   
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        $CI->load->library('lreturn');
        $CI->load->model('Returnse');

        #
        #pagination starts
        #
        $config["base_url"] = base_url('Cretrun_m/manufacturer_return_list/');
        $config["total_rows"] = $this->Returnse->manufacturer_return_list_count();
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
        $content =$this->lreturn->manufacturer_return_list($links,$config["per_page"],$page);
        $this->template->full_admin_html_view($content);
    }
// wastage return list start
    public function wastage_return_list()
    {   
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        $CI->load->library('lreturn');
        $CI->load->model('Returnse');

        #
        #pagination starts
        #
        $config["base_url"] = base_url('Cretrun_m/wastage_return_list/');
        $config["total_rows"] = $this->Returnse->wastage_return_list_count();
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
        $content =$this->lreturn->wastage_return_list($links,$config["per_page"],$page);
        $this->template->full_admin_html_view($content);
    }
    //wastage return list end
    public function invoice_inserted_data($ret_id)
    {   
        $CI =& get_instance();
        $CI->auth->check_admin_auth();
        $CI->load->library('lreturn');
        $content = $CI->lreturn->invoice_html_data($ret_id);        
        $this->template->full_admin_html_view($content);
    }

// Return delete with invoice id
    public function delete_retutn_invoice($invoice_id = null) 
    { 
          $this->load->model('Returnse');
        if ($this->Returnse->returninvoice_delete($invoice_id)) {
            #set success message
            $this->session->set_flashdata('message',display('delete_successfully'));
        } else {
            #set exception message
            $this->session->set_flashdata('exception',display('please_try_again'));

        }
        redirect("Cretrun_m/return_list");
    }
    // return delete with purchase id 
     public function delete_retutn_purchase($purchase_id = null) 
    { 
          $this->load->model('Returnse');
        if ($this->Returnse->return_purchase_delete($purchase_id)) {
            #set success message
            $this->session->set_flashdata('message',display('delete_successfully'));
        } else {
            #set exception message
            $this->session->set_flashdata('exception',display('please_try_again'));

        }
        redirect("Cretrun_m/manufacturer_return_list");
    }
    // date wise manufacturer return list
     public function datebwteen_manufacturer_return_list()
    {   
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        $CI->load->library('lreturn');
        $CI->load->model('Returnse');

        #
        #pagination starts
        #
        $config["base_url"] = base_url('Cretrun_m/manufacturer_return_list/');
        $config["total_rows"] = $this->Returnse->manufacturer_return_list_count();
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
       $from_date = $this->input->post('from_date',true);       
        $to_date = $this->input->post('to_date',true);
        $content =$this->lreturn->datewise_manufacturer_return_list($from_date,$to_date,$links,$config["per_page"],$page);
        $this->template->full_admin_html_view($content);
    }

    //Search manufacturer for return Medicine
    public function search_manufacture()
    {
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        $CI->load->library('lreturn');
        $manufacturer_id=$this->input->post('manufacturer_id',true);
        $content =$this->lreturn->manufacturer_returninfo($manufacturer_id);
        $this->template->full_admin_html_view($content);
    }


         public function datebwteen_wastage_return_list()
    {   
        $CI =& get_instance();
        $this->auth->check_admin_auth();
        $CI->load->library('lreturn');
        $CI->load->model('Returnse');
        $from_date = $this->input->post('from_date',true);       
        $to_date = $this->input->post('to_date',true);
        #
        #pagination starts
        #
        $config["base_url"] = base_url('Cretrun_m/datebwteen_wastage_return_list/');
        $config["total_rows"] = $this->Returnse->wastage_return_list_countdate($from_date,$to_date);
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
        $content =$this->lreturn->datewise_manufacturer_return_list($from_date,$to_date,$links,$config["per_page"],$page);
        $this->template->full_admin_html_view($content);
    }

    // ================= Rekapitulasi Excel =================
    // Ketiga daftar memakai tabel product_return dan hanya dibedakan kolom
    // `usablity`, jadi proses unduhnya dikerjakan satu fungsi bersama.

    // Daftar Pengembalian Stock
    public function recap_stock_return()
    {
        $this->export_return_recap(1, 'Rekap Pengembalian Stock', 'rekap_pengembalian_stock');
    }

    // Daftar Pengembalian Distribusi
    public function recap_manufacturer_return()
    {
        $this->export_return_recap(2, 'Rekap Pengembalian Distribusi', 'rekap_pengembalian_distribusi');
    }

    // Daftar Pemusnahan
    public function recap_wastage_return()
    {
        $this->export_return_recap(3, 'Rekap Pemusnahan', 'rekap_pemusnahan');
    }

    /**
     * Tulis berkas rekapitulasi pengembalian ke Excel/CSV.
     *
     * Rentang tanggal diambil dari query string (?from_date=&to_date=)
     * supaya hasil unduhan mengikuti filter yang sedang dipakai di layar.
     * Bila kosong, seluruh data ikut terunduh.
     *
     * Nilai angka ditulis mentah tanpa pemisah ribuan maupun simbol mata
     * uang, supaya di Excel langsung terbaca sebagai angka.
     */
    private function export_return_recap($usablity, $judul, $prefix_berkas)
    {
        $this->auth->check_admin_auth();
        $this->load->model('Returnse');

        $from_date = $this->input->get('from_date', true);
        $to_date   = $this->input->get('to_date', true);
        // Tanggal yang tidak dikenali diabaikan agar tidak menyaring apa pun.
        if (empty($from_date) || empty($to_date) || strtotime($from_date) === FALSE || strtotime($to_date) === FALSE) {
            $from_date = null;
            $to_date   = null;
        } else {
            $from_date = date('Y-m-d', strtotime($from_date));
            $to_date   = date('Y-m-d', strtotime($to_date));
        }

        $rows = $this->Returnse->return_recap($usablity, $from_date, $to_date);

        $filename = $prefix_berkas.'_'.date('Ymd_His').'.csv';
        header('Content-Type: text/csv; charset=UTF-8');
        header('Content-Disposition: attachment; filename="'.$filename.'"');
        header('Pragma: no-cache');
        header('Expires: 0');

        $out = fopen('php://output', 'w');
        // BOM UTF-8 supaya Excel membaca huruf beraksen dengan benar.
        fwrite($out, "\xEF\xBB\xBF");

        // --- Kepala laporan ---------------------------------------------
        fputcsv($out, array($judul));
        fputcsv($out, array('Tanggal Unduh', date('Y-m-d H:i:s')));
        if ($from_date !== null) {
            fputcsv($out, array('Periode', $from_date.' s/d '.$to_date));
        } else {
            fputcsv($out, array('Periode', 'Semua data'));
        }
        fputcsv($out, array(''));

        // Kolom "Pelanggan" hanya relevan untuk pengembalian stok (dari
        // penjualan); dua daftar lainnya berhubungan dengan distributor.
        $pakai_pelanggan = ($usablity == 1);

        $header = array('No', 'ID Pengembalian');
        $header[] = ($pakai_pelanggan ? 'ID Faktur' : 'ID Pembelian');
        $header[] = ($pakai_pelanggan ? 'Pelanggan' : 'Distributor');
        $header = array_merge($header, array(
            'Tanggal Pembelian', 'Tanggal Pengembalian', 'Nama Barang',
            'Jumlah Beli', 'Jumlah Kembali', 'Harga Satuan',
            'Potongan', 'Total Potongan', 'Pajak',
            'Total Pengembalian', 'Jumlah Bersih', 'Alasan',
        ));
        fputcsv($out, $header);

        // --- Isi ---------------------------------------------------------
        $sl = 1;
        $t_ret_qty = 0; $t_ret_amount = 0; $t_net = 0; $t_deduct = 0; $t_tax = 0;
        foreach ($rows as $r) {
            fputcsv($out, array(
                $sl,
                $r['return_id'],
                ($pakai_pelanggan ? $r['invoice_id'] : $r['purchase_id']),
                ($pakai_pelanggan
                    ? ($r['customer_name'] != '' ? $r['customer_name'] : '-')
                    : ($r['manufacturer_name'] != '' ? $r['manufacturer_name'] : '-')),
                $r['date_purchase'],
                $r['date_return'],
                ($r['product_name'] != '' ? medicine_name($r['product_name'], $r['strength'], ' - ') : '-'),
                (float) $r['byy_qty'],
                (float) $r['ret_qty'],
                (float) $r['product_rate'],
                (float) $r['deduction'],
                (float) $r['total_deduct'],
                (float) $r['total_tax'],
                (float) $r['total_ret_amount'],
                (float) $r['net_total_amount'],
                $r['reason'],
            ));
            $t_ret_qty    += (float) $r['ret_qty'];
            $t_deduct     += (float) $r['total_deduct'];
            $t_tax        += (float) $r['total_tax'];
            $t_ret_amount += (float) $r['total_ret_amount'];
            $t_net        += (float) $r['net_total_amount'];
            $sl++;
        }

        // --- Ringkasan ---------------------------------------------------
        fputcsv($out, array(''));
        fputcsv($out, array(
            '', 'TOTAL', '', '', '', '', '',
            '', $t_ret_qty, '', '', $t_deduct, $t_tax, $t_ret_amount, $t_net, '',
        ));
        fputcsv($out, array('', 'Jumlah Baris', count($rows)));

        fclose($out);
        exit;
    }

}