<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Excel_export
 *
 * Penulis file .xlsx sederhana (SpreadsheetML / Office Open XML) yang
 * berdiri sendiri, tanpa perlu library eksternal seperti PhpSpreadsheet.
 * Cukup untuk kebutuhan laporan: judul, header tabel, baris data, dan
 * baris total.
 *
 * Angka dikirim sebagai angka asli (bukan teks) supaya bisa langsung
 * dijumlahkan di Excel. Kolom uang diberi format ribuan dua desimal.
 *
 * Cara pakai:
 *   $this->load->library('excel_export');
 *   $this->excel_export->download('nama_file.xlsx', array(
 *       array(
 *           'name'    => 'Penjualan',
 *           'title'   => array('Apotek Alang', 'Laporan Penjualan Hari Ini'),
 *           'header'  => array('Tanggal','No Faktur','Pelanggan','Total'),
 *           'rows'    => array( array('01-01-2026','INV1','Budi', 15000), ... ),
 *           'money'   => array(3),          // indeks kolom (0-based) berformat uang
 *           'number'  => array(4),          // kolom angka biasa, mis. jumlah
 *           'footer'  => array('','','Total', 15000),
 *       ),
 *   ));
 */
class Excel_export {

	/** Format angka kustom yang didaftarkan di styles.xml (numFmtId 164). */
	const MONEY_FORMAT = '#,##0.00';

	/**
	 * Bangun file xlsx lalu kirim sebagai unduhan dan hentikan eksekusi.
	 *
	 * @param string $filename Nama file, sebaiknya berakhiran .xlsx
	 * @param array  $sheets   Daftar definisi sheet (lihat contoh di atas)
	 * @return void
	 */
	public function download($filename, array $sheets)
	{
		$binary = $this->build($sheets);

		// Bersihkan buffer apa pun supaya file tidak tercampur output HTML.
		while (ob_get_level() > 0) {
			ob_end_clean();
		}

		$safe_name = preg_replace('/[^A-Za-z0-9_\-\.]/', '_', $filename);

		header('Content-Description: File Transfer');
		header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
		header('Content-Disposition: attachment; filename="'.$safe_name.'"');
		header('Content-Transfer-Encoding: binary');
		header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
		header('Pragma: public');
		header('Content-Length: '.strlen($binary));

		echo $binary;
		exit;
	}

	/**
	 * Rakit isi file xlsx dan kembalikan sebagai string biner.
	 *
	 * @param array $sheets
	 * @return string
	 */
	public function build(array $sheets)
	{
		if (empty($sheets)) {
			$sheets = array(array('name' => 'Sheet1', 'header' => array(), 'rows' => array()));
		}

		$sheets = array_values($sheets);
		$files  = array();

		$files['[Content_Types].xml'] = $this->content_types(count($sheets));
		$files['_rels/.rels']         = $this->root_rels();
		$files['xl/workbook.xml']     = $this->workbook($sheets);
		$files['xl/_rels/workbook.xml.rels'] = $this->workbook_rels(count($sheets));
		$files['xl/styles.xml']       = $this->styles();

		foreach ($sheets as $index => $sheet) {
			$files['xl/worksheets/sheet'.($index + 1).'.xml'] = $this->worksheet($sheet);
		}

		return $this->zip($files);
	}

	# =================================================================
	# Bagian XML
	# =================================================================

	private function content_types($sheet_count)
	{
		$overrides = '';
		for ($i = 1; $i <= $sheet_count; $i++) {
			$overrides .= '<Override PartName="/xl/worksheets/sheet'.$i.'.xml" '
				. 'ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>';
		}

		return '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
			. '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">'
			. '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>'
			. '<Default Extension="xml" ContentType="application/xml"/>'
			. '<Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>'
			. '<Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>'
			. $overrides
			. '</Types>';
	}

	private function root_rels()
	{
		return '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
			. '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
			. '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>'
			. '</Relationships>';
	}

	private function workbook(array $sheets)
	{
		$entries = '';
		foreach ($sheets as $index => $sheet) {
			$name = $this->sheet_name(isset($sheet['name']) ? $sheet['name'] : 'Sheet'.($index + 1), $index);
			$entries .= '<sheet name="'.$this->esc($name).'" sheetId="'.($index + 1).'" r:id="rId'.($index + 1).'"/>';
		}

		return '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
			. '<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" '
			. 'xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">'
			. '<sheets>'.$entries.'</sheets>'
			. '</workbook>';
	}

	private function workbook_rels($sheet_count)
	{
		$rels = '';
		for ($i = 1; $i <= $sheet_count; $i++) {
			$rels .= '<Relationship Id="rId'.$i.'" '
				. 'Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" '
				. 'Target="worksheets/sheet'.$i.'.xml"/>';
		}
		$rels .= '<Relationship Id="rId'.($sheet_count + 1).'" '
			. 'Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" '
			. 'Target="styles.xml"/>';

		return '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
			. '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
			. $rels
			. '</Relationships>';
	}

	/**
	 * Daftar style. Indeks cellXfs yang dipakai:
	 *   0 = normal teks
	 *   1 = judul (tebal, ukuran 14)
	 *   2 = header tabel (tebal, latar abu, bergaris)
	 *   3 = data bergaris
	 *   4 = data bergaris format uang
	 *   5 = footer tebal bergaris
	 *   6 = footer tebal bergaris format uang
	 */
	private function styles()
	{
		return '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
			. '<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">'
			. '<numFmts count="1"><numFmt numFmtId="164" formatCode="'.$this->esc(self::MONEY_FORMAT).'"/></numFmts>'
			. '<fonts count="3">'
				. '<font><sz val="11"/><name val="Calibri"/></font>'
				. '<font><b/><sz val="11"/><name val="Calibri"/></font>'
				. '<font><b/><sz val="14"/><name val="Calibri"/></font>'
			. '</fonts>'
			. '<fills count="3">'
				. '<fill><patternFill patternType="none"/></fill>'
				. '<fill><patternFill patternType="gray125"/></fill>'
				. '<fill><patternFill patternType="solid"><fgColor rgb="FFD9E1F2"/><bgColor indexed="64"/></patternFill></fill>'
			. '</fills>'
			. '<borders count="2">'
				. '<border><left/><right/><top/><bottom/><diagonal/></border>'
				. '<border><left style="thin"><color rgb="FF999999"/></left>'
					. '<right style="thin"><color rgb="FF999999"/></right>'
					. '<top style="thin"><color rgb="FF999999"/></top>'
					. '<bottom style="thin"><color rgb="FF999999"/></bottom><diagonal/></border>'
			. '</borders>'
			. '<cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs>'
			. '<cellXfs count="7">'
				. '<xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/>'
				. '<xf numFmtId="0" fontId="2" fillId="0" borderId="0" xfId="0" applyFont="1"/>'
				. '<xf numFmtId="0" fontId="1" fillId="2" borderId="1" xfId="0" applyFont="1" applyFill="1" applyBorder="1"/>'
				. '<xf numFmtId="0" fontId="0" fillId="0" borderId="1" xfId="0" applyBorder="1"/>'
				. '<xf numFmtId="164" fontId="0" fillId="0" borderId="1" xfId="0" applyNumberFormat="1" applyBorder="1"/>'
				. '<xf numFmtId="0" fontId="1" fillId="0" borderId="1" xfId="0" applyFont="1" applyBorder="1"/>'
				. '<xf numFmtId="164" fontId="1" fillId="0" borderId="1" xfId="0" applyNumberFormat="1" applyFont="1" applyBorder="1"/>'
			. '</cellXfs>'
			. '<cellStyles count="1"><cellStyle name="Normal" xfId="0" builtinId="0"/></cellStyles>'
			. '</styleSheet>';
	}

	/**
	 * Bangun satu worksheet lengkap: judul, header, data, footer.
	 *
	 * @param array $sheet
	 * @return string
	 */
	private function worksheet(array $sheet)
	{
		$titles = isset($sheet['title'])  ? (array) $sheet['title'] : array();
		$header = isset($sheet['header']) ? array_values((array) $sheet['header']) : array();
		$rows   = isset($sheet['rows'])   ? (array) $sheet['rows'] : array();
		$footer = isset($sheet['footer']) && $sheet['footer'] ? array_values((array) $sheet['footer']) : array();
		$money  = isset($sheet['money'])  ? array_flip((array) $sheet['money']) : array();
		// Kolom angka biasa (mis. jumlah/qty): tetap ditulis sebagai angka
		// supaya bisa dijumlahkan, tapi tanpa format ribuan dua desimal.
		$number = isset($sheet['number']) ? array_flip((array) $sheet['number']) : array();

		$xml     = '';
		$row_num = 0;

		// Baris judul: satu kolom saja, gaya tebal besar.
		foreach ($titles as $title) {
			$row_num++;
			$xml .= '<row r="'.$row_num.'">'
				. $this->cell(1, $row_num, $title, 1, false)
				. '</row>';
		}

		// Satu baris kosong sebagai pemisah kalau ada judul.
		if ($titles) {
			$row_num++;
		}

		if ($header) {
			$row_num++;
			$cells = '';
			foreach ($header as $col => $value) {
				$cells .= $this->cell($col + 1, $row_num, $value, 2, false);
			}
			$xml .= '<row r="'.$row_num.'">'.$cells.'</row>';
		}

		foreach ($rows as $row) {
			$row_num++;
			$cells = '';
			foreach (array_values((array) $row) as $col => $value) {
				$is_money   = isset($money[$col]);
				$is_numeric = $is_money || isset($number[$col]);
				$cells     .= $this->cell($col + 1, $row_num, $value, ($is_money ? 4 : 3), $is_numeric);
			}
			$xml .= '<row r="'.$row_num.'">'.$cells.'</row>';
		}

		if ($footer) {
			$row_num++;
			$cells = '';
			foreach ($footer as $col => $value) {
				$is_money   = isset($money[$col]);
				$is_numeric = $is_money || isset($number[$col]);
				$cells     .= $this->cell($col + 1, $row_num, $value, ($is_money ? 6 : 5), $is_numeric);
			}
			$xml .= '<row r="'.$row_num.'">'.$cells.'</row>';
		}

		return '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
			. '<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">'
			. $this->columns($header, $rows)
			. '<sheetData>'.$xml.'</sheetData>'
			. '</worksheet>';
	}

	/**
	 * Perkirakan lebar kolom dari isi terpanjang supaya tidak tampil "####".
	 *
	 * @param array $header
	 * @param array $rows
	 * @return string
	 */
	private function columns(array $header, array $rows)
	{
		$widths = array();

		foreach ($header as $col => $value) {
			$widths[$col] = strlen((string) $value);
		}

		// Cukup sampel 200 baris pertama; laporan besar tidak perlu diukur semua.
		$sampled = 0;
		foreach ($rows as $row) {
			foreach (array_values((array) $row) as $col => $value) {
				$len = strlen((string) $value);
				if (!isset($widths[$col]) || $len > $widths[$col]) {
					$widths[$col] = $len;
				}
			}
			if (++$sampled >= 200) {
				break;
			}
		}

		if (empty($widths)) {
			return '';
		}

		$cols = '';
		foreach ($widths as $col => $len) {
			$width = min(max($len + 4, 10), 50);
			$cols .= '<col min="'.($col + 1).'" max="'.($col + 1).'" width="'.$width.'" customWidth="1"/>';
		}

		return '<cols>'.$cols.'</cols>';
	}

	/**
	 * Bangun satu sel. Nilai numerik ditulis sebagai angka, sisanya
	 * sebagai inline string supaya tidak perlu sharedStrings.xml.
	 *
	 * @param int   $col_index Nomor kolom mulai 1
	 * @param int   $row_index Nomor baris mulai 1
	 * @param mixed $value
	 * @param int   $style     Indeks cellXfs
	 * @param bool  $numeric   Paksa perlakukan sebagai angka
	 * @return string
	 */
	private function cell($col_index, $row_index, $value, $style, $numeric)
	{
		$ref = $this->column_letter($col_index).$row_index;

		if ($value === null || $value === '') {
			return '<c r="'.$ref.'" s="'.$style.'"/>';
		}

		if ($numeric || is_int($value) || is_float($value)) {
			$number = $this->to_number($value);
			return '<c r="'.$ref.'" s="'.$style.'"><v>'.$number.'</v></c>';
		}

		return '<c r="'.$ref.'" s="'.$style.'" t="inlineStr"><is><t xml:space="preserve">'
			. $this->esc($value).'</t></is></c>';
	}

	/**
	 * Ubah nilai dari database/tampilan menjadi angka polos.
	 * Menerima "1.234,56" (format Indonesia), "1,234.56", "Rp 5.000",
	 * maupun angka biasa.
	 *
	 * @param mixed $value
	 * @return string
	 */
	private function to_number($value)
	{
		if (is_int($value) || is_float($value)) {
			return rtrim(rtrim(number_format((float) $value, 4, '.', ''), '0'), '.') ?: '0';
		}

		// Buang semua karakter selain angka, titik, koma, dan minus.
		$clean = preg_replace('/[^0-9,.\-]/', '', (string) $value);

		if ($clean === '' || $clean === '-') {
			return '0';
		}

		$last_dot   = strrpos($clean, '.');
		$last_comma = strrpos($clean, ',');

		if ($last_dot !== false && $last_comma !== false) {
			// Pemisah desimal adalah tanda baca yang muncul paling akhir.
			if ($last_comma > $last_dot) {
				$clean = str_replace('.', '', $clean);
				$clean = str_replace(',', '.', $clean);
			} else {
				$clean = str_replace(',', '', $clean);
			}
		} elseif ($last_comma !== false) {
			// Koma tunggal: desimal kalau diikuti 1-2 digit, selain itu ribuan.
			$decimals = strlen($clean) - $last_comma - 1;
			$clean = ($decimals > 0 && $decimals <= 2)
				? str_replace(',', '.', $clean)
				: str_replace(',', '', $clean);
		} elseif ($last_dot !== false) {
			// Titik tunggal: ribuan kalau diikuti tepat 3 digit dan ada digit
			// di depannya (mis. "15.000"), selain itu desimal.
			$decimals = strlen($clean) - $last_dot - 1;
			if ($decimals === 3 && $last_dot > 0) {
				$clean = str_replace('.', '', $clean);
			}
		}

		return is_numeric($clean) ? $clean : '0';
	}

	/**
	 * Ubah nomor kolom menjadi huruf Excel (1 => A, 27 => AA).
	 *
	 * @param int $index
	 * @return string
	 */
	private function column_letter($index)
	{
		$letter = '';
		while ($index > 0) {
			$mod    = ($index - 1) % 26;
			$letter = chr(65 + $mod).$letter;
			$index  = (int) (($index - $mod) / 26);
		}
		return $letter;
	}

	/**
	 * Nama sheet Excel: maksimal 31 karakter dan tanpa karakter terlarang.
	 *
	 * @param string $name
	 * @param int    $index
	 * @return string
	 */
	private function sheet_name($name, $index)
	{
		$name = str_replace(array('\\', '/', '?', '*', '[', ']', ':'), ' ', (string) $name);
		$name = trim(preg_replace('/\s+/', ' ', $name));
		if ($name === '') {
			$name = 'Sheet'.($index + 1);
		}
		return mb_substr($name, 0, 31);
	}

	private function esc($text)
	{
		// Buang karakter kontrol yang membuat XML tidak valid.
		$text = preg_replace('/[\x00-\x08\x0B\x0C\x0E-\x1F]/', '', (string) $text);
		return htmlspecialchars($text, ENT_QUOTES, 'UTF-8');
	}

	# =================================================================
	# Pembungkus ZIP
	# =================================================================

	/**
	 * Bungkus daftar file menjadi arsip zip (format xlsx).
	 *
	 * Arsip dirakit sepenuhnya di memori. Sengaja tidak memakai ZipArchive
	 * karena kelas itu wajib menulis ke file, sedangkan direktori temporary
	 * sistem tidak selalu bisa ditulis oleh user Apache (di macOS/XAMPP
	 * tempnam() gagal dan memunculkan notice). Laporan berukuran wajar,
	 * jadi merakit di memori aman dan sekaligus menghilangkan file sampah.
	 *
	 * Semua isi disimpan tanpa kompresi (metode 0/store). File xlsx tetap
	 * sah karena spesifikasi zip mengizinkannya, dan Excel membacanya normal.
	 *
	 * @param array $files Peta nama-di-dalam-arsip => isi
	 * @return string
	 */
	private function zip(array $files)
	{
		$local   = '';   // rangkaian local file header + data
		$central = '';   // rangkaian central directory header
		$count   = 0;
		$offset  = 0;

		// Zip menyimpan waktu dalam format DOS.
		$dos_time = $this->dos_time();

		foreach ($files as $path => $content) {
			$path   = (string) $path;
			$crc    = crc32($content);
			$size   = strlen($content);

			// Local file header (tanda tangan 0x04034b50).
			$header = "\x50\x4b\x03\x04"
				. pack('v', 20)        // versi minimum untuk ekstrak (2.0)
				. pack('v', 0)         // flag umum
				. pack('v', 0)         // metode kompresi: 0 = store
				. pack('V', $dos_time) // waktu + tanggal modifikasi
				. pack('V', $crc)
				. pack('V', $size)     // ukuran terkompresi
				. pack('V', $size)     // ukuran asli
				. pack('v', strlen($path))
				. pack('v', 0);        // panjang extra field

			$local .= $header.$path.$content;

			// Central directory header (tanda tangan 0x02014b50).
			$central .= "\x50\x4b\x01\x02"
				. pack('v', 20)        // versi pembuat
				. pack('v', 20)        // versi minimum untuk ekstrak
				. pack('v', 0)
				. pack('v', 0)
				. pack('V', $dos_time)
				. pack('V', $crc)
				. pack('V', $size)
				. pack('V', $size)
				. pack('v', strlen($path))
				. pack('v', 0)         // extra field
				. pack('v', 0)         // komentar file
				. pack('v', 0)         // nomor disk
				. pack('v', 0)         // atribut internal
				. pack('V', 32)        // atribut eksternal (arsip)
				. pack('V', $offset)   // posisi local header
				. $path;

			$offset = strlen($local);
			$count++;
		}

		// End of central directory (tanda tangan 0x06054b50).
		$end = "\x50\x4b\x05\x06"
			. pack('v', 0)              // nomor disk ini
			. pack('v', 0)              // disk tempat central directory mulai
			. pack('v', $count)         // jumlah entri di disk ini
			. pack('v', $count)         // jumlah entri total
			. pack('V', strlen($central))
			. pack('V', strlen($local)) // posisi awal central directory
			. pack('v', 0);             // panjang komentar arsip

		return $local.$central.$end;
	}

	/**
	 * Waktu sekarang dalam format tanggal+waktu DOS yang dipakai zip.
	 *
	 * @return int
	 */
	private function dos_time()
	{
		$y = (int) date('Y');
		// Format DOS hanya mampu menyimpan tahun 1980 ke atas.
		if ($y < 1980) {
			return (1 << 21) | (1 << 16);
		}

		return (($y - 1980) << 25)
			| ((int) date('n') << 21)
			| ((int) date('j') << 16)
			| ((int) date('G') << 11)
			| ((int) date('i') << 5)
			| ((int) date('s') >> 1);
	}
}
