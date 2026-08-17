<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Model Stock Opname
 *
 * Opname TIDAK menimpa stok. Yang disimpan adalah SELISIH antara stok fisik
 * dan stok sistem, sehingga data pembelian & penjualan tidak pernah disentuh.
 * Stok akhir dihitung oleh view_stock_current:
 *
 *     Stok = Pembelian - Penjualan + Sum(selisih opname yang sudah diposting)
 */
class Stock_opname extends CI_Model
{
	public function __construct()
	{
		parent::__construct();
		$this->load->database();
	}

	/*
	** Daftar kategori alasan. Disimpan sebagai kode di kolom VARCHAR,
	** labelnya diambil dari tabel language lewat display().
	*/
	public function reason_list()
	{
		return array(
			'damaged'     => 'reason_damaged',
			'expired'     => 'reason_expired',
			'lost'        => 'reason_lost',
			'miscount'    => 'reason_miscount',
			'input_error' => 'reason_input_error',
			'found'       => 'reason_found',
			'other'       => 'reason_other',
		);
	}

	/*
	** Nomor opname berurut per hari: OPN-YYYYMMDD-NNNN
	*/
	public function generate_opname_no()
	{
		$prefix = 'OPN-'.date('Ymd').'-';
		$this->db->select('opname_no');
		$this->db->from('stock_opname');
		$this->db->like('opname_no', $prefix, 'after');
		$this->db->order_by('opname_no', 'desc');
		$this->db->limit(1);
		$row = $this->db->get()->row();

		$next = 1;
		if ($row) {
			$next = (int) substr($row->opname_no, strlen($prefix)) + 1;
		}
		return $prefix.str_pad($next, 4, '0', STR_PAD_LEFT);
	}

	/*
	** Stok sistem terkini untuk satu produk, diambil dari view terpusat.
	** Selalu dipanggil ulang di server saat menyimpan -- angka dari form
	** tidak boleh dipercaya karena bisa sudah basi atau dimanipulasi.
	*/
	public function get_current_stock($product_id)
	{
		$row = $this->db->select('stock')
					->from('view_stock_current')
					->where('product_id', $product_id)
					->get()->row();
		return $row ? (float) $row->stock : 0;
	}

	/*
	** Daftar produk beserta stok sistem, untuk mengisi form opname.
	*/
	public function product_for_opname($keyword = null, $manufacturer_id = null, $limit = 100)
	{
		$this->db->select('a.product_id, a.product_name, a.strength, a.unit,
						   m.manufacturer_name, IFNULL(v.stock,0) as stock');
		$this->db->from('product_information a');
		$this->db->join('view_stock_current v', 'v.product_id = a.product_id', 'left');
		$this->db->join('manufacturer_information m', 'm.manufacturer_id = a.manufacturer_id', 'left');
		$this->db->where('a.status', 1);

		if (!empty($keyword)) {
			$this->db->group_start();
			$this->db->like('a.product_name', $keyword);
			$this->db->or_like('a.generic_name', $keyword);
			$this->db->or_like('a.product_id', $keyword);
			$this->db->group_end();
		}
		if (!empty($manufacturer_id)) {
			$this->db->where('a.manufacturer_id', $manufacturer_id);
		}

		$this->db->order_by('a.product_name', 'asc');
		$this->db->limit($limit);
		return $this->db->get()->result_array();
	}

	/*
	** Simpan sesi opname.
	**
	** $post_now = TRUE  -> langsung diposting (status 1, stok berubah)
	** $post_now = FALSE -> disimpan sebagai draft (status 0, stok belum berubah)
	**
	** Mengembalikan opname_id bila berhasil, FALSE bila gagal.
	*/
	public function save_opname($post_now = false)
	{
		$user_id = $this->session->userdata('user_id');
		$now     = date('Y-m-d H:i:s');
		$tanggal = date('Y-m-d', strtotime($now));
		$jam     = date('H:i:s', strtotime($now));
		$status  = ($post_now ? 1 : 0);

		$product_ids = $this->input->post('product_id');
		$qty_phys    = $this->input->post('qty_physical');
		$reasons     = $this->input->post('reason_code');
		$notes       = $this->input->post('reason_note');

		if (empty($product_ids) || !is_array($product_ids)) {
			return false;
		}

		$this->db->trans_start();

		$opname_no = $this->generate_opname_no();

		$this->db->insert('stock_opname', array(
			'opname_no'   => $opname_no,
			'opname_date' => $tanggal,
			'opname_time' => $jam,
			'note'        => $this->input->post('note', true),
			'status'      => $status,
			'created_by'  => $user_id,
			'created_at'  => $now,
			'posted_by'   => ($post_now ? $user_id : null),
			'posted_at'   => ($post_now ? $now : null),
		));
		$opname_id = $this->db->insert_id();

		$total_item    = 0;
		$total_selisih = 0;

		for ($i = 0; $i < count($product_ids); $i++) {

			if ($product_ids[$i] === '' || !isset($qty_phys[$i]) || $qty_phys[$i] === '') {
				continue;
			}

			// Stok sistem diambil ULANG dari server, bukan dari input form.
			$qty_system = $this->get_current_stock($product_ids[$i]);
			$qty_fisik  = (float) $qty_phys[$i];
			$selisih    = $qty_fisik - $qty_system;

			// Tanpa selisih tidak perlu dicatat ke log.
			if (abs($selisih) < 0.001) {
				continue;
			}

			$this->db->insert('stock_opname_details', array(
				'opname_id'      => $opname_id,
				'opname_no'      => $opname_no,
				'product_id'     => $product_ids[$i],
				'qty_system'     => $qty_system,
				'qty_physical'   => $qty_fisik,
				'qty_difference' => $selisih,
				'reason_code'    => (isset($reasons[$i]) && $reasons[$i] !== '' ? $reasons[$i] : 'other'),
				'reason_note'    => (isset($notes[$i]) ? $notes[$i] : null),
				'adjusted_date'  => $tanggal,
				'adjusted_time'  => $jam,
				'adjusted_at'    => $now,
				'adjusted_by'    => $user_id,
				'status'         => $status,
			));

			$total_item++;
			$total_selisih += $selisih;
		}

		$this->db->where('id', $opname_id)->update('stock_opname', array(
			'total_item'    => $total_item,
			'total_selisih' => $total_selisih,
		));

		$this->db->trans_complete();

		return ($this->db->trans_status() ? $opname_id : false);
	}

	/*
	** Posting draft menjadi permanen. Sejak status = 1, selisihnya langsung
	** ikut terhitung oleh view_stock_current.
	*/
	public function post_opname($opname_id)
	{
		$row = $this->db->select('status')->from('stock_opname')
					->where('id', $opname_id)->get()->row();

		// Cegah posting ganda (klik dua kali / refresh halaman).
		if (!$row || $row->status == 1) {
			return false;
		}

		$user_id = $this->session->userdata('user_id');
		$now     = date('Y-m-d H:i:s');

		$this->db->trans_start();
		$this->db->where('id', $opname_id)->update('stock_opname', array(
			'status'    => 1,
			'posted_by' => $user_id,
			'posted_at' => $now,
		));
		$this->db->where('opname_id', $opname_id)
				 ->update('stock_opname_details', array('status' => 1));
		$this->db->trans_complete();

		return $this->db->trans_status();
	}

	/*
	** Hapus draft. Opname yang sudah diposting TIDAK boleh dihapus supaya
	** jejak audit tetap utuh; koreksi dilakukan lewat opname baru.
	*/
	public function delete_draft($opname_id)
	{
		$row = $this->db->select('status')->from('stock_opname')
					->where('id', $opname_id)->get()->row();

		if (!$row || $row->status == 1) {
			return false;
		}

		$this->db->trans_start();
		$this->db->where('opname_id', $opname_id)->delete('stock_opname_details');
		$this->db->where('id', $opname_id)->delete('stock_opname');
		$this->db->trans_complete();

		return $this->db->trans_status();
	}

	/*
	** Daftar sesi opname
	*/
	public function opname_list($limit = null, $offset = null)
	{
		$this->db->select("h.*, CONCAT(IFNULL(u.first_name,''),' ',IFNULL(u.last_name,'')) as nama_user");
		$this->db->from('stock_opname h');
		$this->db->join('users u', 'u.user_id = h.created_by', 'left');
		$this->db->order_by('h.id', 'desc');
		if ($limit !== null) {
			$this->db->limit($limit, $offset);
		}
		return $this->db->get()->result_array();
	}

	public function opname_count()
	{
		return $this->db->count_all('stock_opname');
	}

	public function opname_header($opname_id)
	{
		$this->db->select("h.*,
			CONCAT(IFNULL(u.first_name,''),' ',IFNULL(u.last_name,'')) as nama_pembuat,
			CONCAT(IFNULL(p.first_name,''),' ',IFNULL(p.last_name,'')) as nama_poster");
		$this->db->from('stock_opname h');
		$this->db->join('users u', 'u.user_id = h.created_by', 'left');
		$this->db->join('users p', 'p.user_id = h.posted_by', 'left');
		$this->db->where('h.id', $opname_id);
		return $this->db->get()->row_array();
	}

	public function opname_details($opname_id)
	{
		$this->db->select("d.*, a.product_name, a.strength, a.unit,
			CONCAT(IFNULL(u.first_name,''),' ',IFNULL(u.last_name,'')) as nama_user");
		$this->db->from('stock_opname_details d');
		$this->db->join('product_information a', 'a.product_id = d.product_id', 'left');
		$this->db->join('users u', 'u.user_id = d.adjusted_by', 'left');
		$this->db->where('d.opname_id', $opname_id);
		$this->db->order_by('d.id', 'asc');
		return $this->db->get()->result_array();
	}

	/*
	** LOG AUDIT -- inti dari kebutuhan pencatatan:
	** tanggal, jam, user, stok sebelum, stok sesudah, dan alasan.
	*/
	public function get_opname_log($filter = array())
	{
		$this->db->select("
			d.adjusted_date                                            AS tanggal,
			d.adjusted_time                                            AS jam,
			d.opname_no                                                AS no_opname,
			d.opname_id                                                AS opname_id,
			a.product_name                                             AS nama_produk,
			a.strength                                                 AS kekuatan,
			a.unit                                                     AS satuan,
			d.qty_system                                               AS stok_sebelum,
			d.qty_physical                                             AS stok_sesudah,
			d.qty_difference                                           AS selisih,
			d.reason_code                                              AS kode_alasan,
			d.reason_note                                              AS keterangan,
			CONCAT(IFNULL(u.first_name,''),' ',IFNULL(u.last_name,'')) AS nama_user,
			d.status                                                   AS status_opname
		");
		$this->db->from('stock_opname_details d');
		$this->db->join('product_information a', 'a.product_id = d.product_id', 'left');
		$this->db->join('users u', 'u.user_id = d.adjusted_by', 'left');

		if (!empty($filter['from_date'])) {
			$this->db->where('d.adjusted_date >=', $filter['from_date']);
		}
		if (!empty($filter['to_date'])) {
			$this->db->where('d.adjusted_date <=', $filter['to_date']);
		}
		if (!empty($filter['user_id'])) {
			$this->db->where('d.adjusted_by', $filter['user_id']);
		}
		if (!empty($filter['product_id'])) {
			$this->db->where('d.product_id', $filter['product_id']);
		}
		if (!empty($filter['reason_code'])) {
			$this->db->where('d.reason_code', $filter['reason_code']);
		}
		if (isset($filter['status']) && $filter['status'] !== '') {
			$this->db->where('d.status', $filter['status']);
		}

		$this->db->order_by('d.adjusted_at', 'desc');
		$this->db->order_by('d.id', 'desc');
		return $this->db->get()->result_array();
	}

	/*
	** Daftar user yang pernah melakukan penyesuaian, untuk dropdown filter log.
	*/
	public function log_user_list()
	{
		$this->db->distinct();
		$this->db->select("d.adjusted_by as user_id,
			CONCAT(IFNULL(u.first_name,''),' ',IFNULL(u.last_name,'')) as nama_user");
		$this->db->from('stock_opname_details d');
		$this->db->join('users u', 'u.user_id = d.adjusted_by', 'left');
		return $this->db->get()->result_array();
	}
}
