<?php 
defined('BASEPATH') OR exit('No direct script access allowed');

if (!function_exists('medicine_name')) {

    /**
     * Tampilkan nama obat saja.
     *
     * Bagian dalam kurung (strength / product_model) tidak lagi ikut
     * ditampilkan, baik saat isinya kosong maupun terisi. Jadi tidak
     * pernah muncul "Nama Obat ()" atau "Nama Obat (500mg)".
     *
     * Parameter $strength dan $separator sengaja dipertahankan supaya
     * seluruh pemanggil lama tetap jalan tanpa perlu diubah.
     *
     * @param  string $product_name
     * @param  string $strength     diabaikan
     * @param  string $separator    diabaikan
     * @return string
     */
    function medicine_name($product_name = null, $strength = null, $separator = '')
    {
        return trim((string) $product_name);
    }

}

if (!function_exists('display')) {

    function display($text = null)
    {
        $ci =& get_instance();
        $ci->load->database();
        $table  = 'language';
        $phrase = 'phrase';
        $setting_table = 'web_setting';
        $default_lang  = 'english';

        //set language  
        $data = $ci->db->get($setting_table)->row();
        if (!empty($data->language)) {
            $language = $data->language; 
        } else {
            $language = $default_lang; 
        } 
 
        if (!empty($text)) {

            if ($ci->db->table_exists($table)) { 

                if ($ci->db->field_exists($phrase, $table)) { 

                    if ($ci->db->field_exists($language, $table)) {

                        $row = $ci->db->select($language)
                              ->from($table)
                              ->where($phrase, $text)
                              ->get()
                              ->row(); 

                        if (!empty($row->$language)) {
                            return html_escape($row->$language);
                        } else {
                            return false;
                        }

                    } else {
                        return false;
                    }

                } else {
                    return false;
                }

            } else {
                return false;
            }            
        } else {
            return false;
        }  

    }
 
}

 

if (!function_exists('payment_needs_bank')) {

    /**
     * Apakah satu jenis pembayaran perlu memilih rekening bank?
     *
     * Dulu form transaksi menampilkan kolom bank hanya kalau nilai yang
     * dipilih kebetulan bernilai 2, karena pilihannya ditulis tetap
     * (1 = Cash, 2 = Bank). Setelah pilihan diambil dari master
     * payment_type, id 2 tidak lagi dijamin berarti "bank" - dan jenis
     * baru yang ditambahkan admin (id 3, 4, ...) tidak akan pernah
     * memunculkan kolom bank.
     *
     * Karena master hanya menyimpan nama, penentuannya memakai nama itu:
     * apa pun selain tunai dianggap lewat bank. Daftar kata tunai dibuat
     * dwibahasa supaya "Cash" maupun "Tunai" sama-sama dikenali.
     *
     * @param  string $payment_type_name Nama jenis pembayaran dari master
     * @return bool                      true bila kolom bank perlu tampil
     */
    function payment_needs_bank($payment_type_name = null)
    {
        $name = strtolower(trim((string) $payment_type_name));

        if ($name === '') {
            return false;
        }

        // Pembayaran tunai (dan sejenisnya) tidak memerlukan rekening bank.
        $cash_words = array('cash', 'tunai', 'cash payment', 'pembayaran tunai');

        foreach ($cash_words as $word) {
            if ($name === $word) {
                return false;
            }
        }

        return true;
    }

}
