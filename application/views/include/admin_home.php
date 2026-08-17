<!-- Admin Home Start -->
 <div class="content-wrapper">
    <!-- Content Header(Page header)-->
    <section class="content-header">
        <div class="header-icon">
            <i class="pe-7s-world"></i>
        </div>
        <div class="header-title">
            <h1><?php echo display('dashboard')?></h1>
            <small><?php echo display('home')?></small>
            <ol class="breadcrumb">
                <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home')?></a></li>
                <li class="active"><?php echo display('dashboard')?></li>
            </ol>
        </div>
    </section>
    <!-- Main content -->
    <section class="content">
              <?php 
if(isset($_POST['btnSearch']))
{
   $postdate = $_POST['alldata'];
   $y = date("Y", strtotime($postdate) );
   $m = date("m", strtotime($postdate) );
  
}
$searchdate =(!empty($postdate)?$postdate:date('F Y'));
   $year = (!empty($y)?$y:date('Y'));
   $month = (!empty($m)?$m:date('m'));

?>
        <!-- Alert Message -->
        <?php
            $message = $this->session->userdata('message');
            if (isset($message)) {
        ?>
        <div class="alert alert-info alert-dismissable">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
            <?php echo $message ?>                    
        </div>
        <?php 
            $this->session->unset_userdata('message');
            }
            $error_message = $this->session->userdata('error_message');
            if (isset($error_message)) {
        ?>
        <div class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
            <?php echo $error_message ?>                    
        </div>
        <?php 
            $this->session->unset_userdata('error_message');
            }
        ?>
        <!-- First Counter -->
        <div class="row">

           <?php
            if($this->permission1->method('manage_customer','read')->access()){ ?>
               <div class="col-xs-12 col-sm-4 col-md-4 col-lg-2">
         
                       <div class="small-box bg-green whitecolor">
            <div class="inner">
              <h4 class="text-center"><span class="coundownnumber"><?php echo html_escape($total_customer)?></span></h4>

              <p class="text-center"><?php echo display('total_customer')?></p>
            </div>
            <div class="icon">
             <i class="fa fa-users"></i>
            </div>
            <a href="<?php echo base_url('Ccustomer/manage_customer')?>" class="small-box-footer"><?php echo display('total_customer')?> </a>
          </div>
               </div>
            <?php } ?>

             <?php
             if($this->permission1->method('manage_manufacturer','read')->access()) { ?>
                <div class="col-xs-12 col-sm-4 col-md-4 col-lg-2">
     
            <div class="small-box bg-bringal whitecolor">
            <div class="inner">
              <h4 class="text-center"><span class="coundownnumber"><?php echo html_escape($total_manufacturers) ?></span></h4>

              <p class="text-center"><?php echo display('total_manufacturer')?></p>
            </div>
            <div class="icon">
             <i class="fa fa-user"></i>
            </div>
            <a href="<?php echo base_url('Cmanufacturer/manage_manufacturer')?>" class="small-box-footer"><?php echo display('total_manufacturer')?> </a>
          </div>
                </div>
             <?php } ?>

            <?php
            if($this->permission1->method('manage_medicine','read')->access()){ ?>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-2">
                   <div class="small-box bg-darkgreen whitecolor">
            <div class="inner">
              <h4 class="text-center"><span class="coundownnumber"><?php echo html_escape($total_product)?></span></h4>

              <p class="text-center"><?php echo display('total_product')?></p>
            </div>
            <div class="icon">
             <i class="fa fa-medkit"></i>
            </div>
            <a href="<?php echo base_url('Cproduct/manage_product')?>" class="small-box-footer"><?php echo display('total_product')?> </a>
          </div>
            </div>
           <?php } ?>


          
                  <?php
                if($this->permission1->method('manage_medicine','read')->access()) { ?>
                <div class="col-xs-12 col-sm-4 col-md-4 col-lg-2">
 
        <div class="small-box bg-orange whitecolor">
            <div class="inner">
              <h4 class="text-center"><span class="coundownnumber"><?php echo html_escape($stockout); ?></span></h4>

              <p class="text-center"><?php echo display('out_of_stock')?></p>
            </div>
            <div class="icon">
             <i class="fa fa-stack-overflow"></i>
            </div>
            <a href="<?php echo base_url('Creport/out_of_stock')?>" class="small-box-footer"><?php echo display('out_of_stock')?> </a>
          </div>
                </div>
                <?php } ?>
                  <?php
                if($this->permission1->method('manage_medicine','read')->access()) { ?>
                <div class="col-xs-12 col-sm-4 col-md-4 col-lg-2">

            <div class="small-box bg-danger whitecolor">
            <div class="inner">
              <h4 class="text-center"><span class="coundownnumber"><?php echo html_escape($expired) ?></span></h4>

              <p class="text-center"><?php echo display('expired')?></p>
            </div>
            <div class="icon">
             <i class="fa fa-calendar"></i>
            </div>
            <a href="<?php echo base_url('Creport/out_of_date')?>" class="small-box-footer"><?php echo display('expired')?> </a>
          </div>
                </div>
                <?php } ?>
                      <?php
                if($this->permission1->method('manage_invoice','read')->access()) { ?>
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-2">
             
            <div class="small-box bg-pase whitecolor">
            <div class="inner">
              <h4 class="text-center"><span class="coundownnumber"><?php echo html_escape($total_sales) ?></span></h4>

              <p class="text-center"><?php echo display('total_invoice')?></p>
            </div>
            <div class="icon">
             <i class="fa fa-print"></i>
            </div>
            <a href="<?php echo base_url('Cinvoice/manage_invoice')?>" class="small-box-footer"><?php echo display('total_invoice')?> </a>
          </div>
                </div>
                <?php } ?>
<?php
 // Input tersembunyi pemasok data grafik lama (Laporan Kemajuan
 // Bulanan, Pendapatan/Pengeluaran, dan Best Sales) sudah dihapus
 // bersama panelnya. Yang disisakan hanya #currency, karena dipakai
 // juga oleh skrip lain di aplikasi ini.
 ?>
 <input type="hidden" id="currency" value="<?php echo  html_escape($currency)?>" name="">
        </div>

        <?php
        // ============================================================
        // KARTU KPI KONDISI PERSEDIAAN
        //
        // Empat angka yang paling perlu ditindaklanjuti sehari-hari.
        // Seluruh kartu bisa diklik dan langsung membuka halaman
        // rinciannya masing-masing.
        //
        // Ditampilkan bila user berhak membaca data obat, sebab isinya
        // adalah kondisi stok & kedaluwarsa obat.
        // ============================================================
        if (!empty($kpi_cards) && $this->permission1->method('manage_medicine','read')->access()) {
        ?>
        <div class="row kpi-card-row">
            <?php foreach ($kpi_cards as $kpi) { ?>
            <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
                <a href="<?php echo $kpi['url']?>" class="kpi-card-link">
                    <div class="small-box <?php echo $kpi['bg']?> whitecolor kpi-card">
                        <div class="inner">
                            <h4 class="text-center">
                                <span class="coundownnumber"><?php echo number_format($kpi['value'], 0, ',', '.')?></span>
                            </h4>

                            <p class="text-center"><?php echo html_escape($kpi['label'])?></p>
                            <p class="text-center kpi-card-note"><small><?php echo html_escape($kpi['note'])?></small></p>
                        </div>
                        <div class="icon">
                            <i class="fa <?php echo $kpi['icon']?>"></i>
                        </div>
                        <span class="small-box-footer">
                            Lihat Detail <i class="fa fa-arrow-circle-right"></i>
                        </span>
                    </div>
                </a>
            </div>
            <?php } ?>
        </div>
        <?php } ?>

        <?php
        // ============================================================
        // RINGKASAN PERIODE: Hari Ini / Minggu Ini / Bulan Ini / Tahun Ini
        //
        // Tiap kartu menampilkan angka pokok penjualan periode itu dan
        // bisa diklik untuk membuka halaman detail (breakdown per
        // hari/minggu/bulan + 10 barang paling laku).
        //
        // Ditampilkan hanya bila user berhak membaca laporan, mengikuti
        // aturan yang sama dengan panel "Laporan Hari Ini" di bawah.
        // ============================================================
        if (!empty($dashboard_periods) && $this->permission1->method('todays_report','read')->access()) {

            // Format rupiah tanpa desimal: nominal apotek selalu bulat,
            // dan angka panjang membuat kartu jadi sulit dibaca.
            if (!function_exists('dashboard_money')) {
                function dashboard_money($amount, $currency, $position) {
                    $value = number_format((float) $amount, 0, ',', '.');
                    return ($position == 0 ? $currency.' '.$value : $value.' '.$currency);
                }
            }

            $period_style = array(
                'today' => array('bg' => 'bg-primary',   'icon' => 'fa-calendar-o'),
                'week'  => array('bg' => 'bg-success',   'icon' => 'fa-calendar-check-o'),
                'month' => array('bg' => 'bg-info',      'icon' => 'fa-calendar'),
                'year'  => array('bg' => 'bg-warning',   'icon' => 'fa-line-chart'),
            );
        ?>
        <div class="row dashboard-period-row">
            <?php foreach ($dashboard_periods as $key => $period) {
                $s       = $period['summary'];
                $style   = (isset($period_style[$key]) ? $period_style[$key] : $period_style['today']);
                $detail  = base_url('Admin_dashboard/period_detail/'.$key);
            ?>
            <!-- Dua kartu per baris: kolom lebih lebar sehingga nama
                 produk pada daftar Top 10 tidak cepat terpotong. -->
            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                <div class="panel panel-bd dashboard-period-card">
                    <div class="panel-heading <?php echo $style['bg']?> whitecolor">
                        <div class="panel-title">
                            <h4 style="margin:0;">
                                <i class="fa <?php echo $style['icon']?>"></i>
                                <?php echo html_escape($period['title'])?>
                            </h4>
                            <small><?php echo date('d/m/Y', strtotime($period['from']))?>
                                <?php if ($period['from'] != $period['to']) { ?>
                                    &ndash; <?php echo date('d/m/Y', strtotime($period['to']))?>
                                <?php } ?>
                            </small>
                        </div>
                    </div>
                    <div class="panel-body">
                        <table class="table table-condensed dashboard-period-table">
                            <tr>
                                <th>Jumlah Obat Terjual</th>
                                <td class="text-right"><?php echo number_format($s['total_qty'], 0, ',', '.')?></td>
                            </tr>
                            <tr>
                                <th>Jumlah Sell Price</th>
                                <td class="text-right"><?php echo dashboard_money($s['total_sell'], $currency, $position)?></td>
                            </tr>
                            <tr>
                                <th>Jumlah Purchase Price</th>
                                <td class="text-right"><?php echo dashboard_money($s['total_cost'], $currency, $position)?></td>
                            </tr>
                            <tr>
                                <th>Gross Margin</th>
                                <td class="text-right <?php echo ($s['gross_margin'] < 0 ? 'text-danger' : 'text-success')?>">
                                    <strong><?php echo dashboard_money($s['gross_margin'], $currency, $position)?></strong>
                                    <br><small>(<?php echo number_format($s['margin_percent'], 2, ',', '.')?>%)</small>
                                </td>
                            </tr>
                            <tr>
                                <th>Jumlah Pelanggan</th>
                                <td class="text-right">
                                    <?php echo number_format($s['total_invoice'], 0, ',', '.')?>
                                    <br><small class="text-muted">transaksi</small>
                                </td>
                            </tr>
                        </table>

                        <div class="dashboard-period-top">
                            <strong><i class="fa fa-trophy"></i> Top 10 Barang Paling Laku</strong>
                            <?php if (!empty($period['top'])) { ?>
                            <ol class="dashboard-top-list">
                                <?php foreach ($period['top'] as $top) { ?>
                                <li>
                                    <span class="dashboard-top-name" title="<?php echo html_escape($top['product_name'])?>"><?php echo html_escape($top['product_name'])?></span>
                                    <span class="dashboard-top-qty"><?php echo number_format($top['total_qty'], 0, ',', '.')?></span>
                                </li>
                                <?php } ?>
                            </ol>
                            <?php } else { ?>
                            <p class="text-muted" style="margin-top:8px;">Belum ada penjualan pada periode ini.</p>
                            <?php } ?>
                        </div>
                    </div>
                    <div class="panel-footer dashboard-period-footer">
                        <a href="<?php echo $detail?>" class="btn btn-primary btn-block">
                            <i class="fa fa-search-plus"></i> Lihat Detail
                        </a>
                    </div>
                </div>
            </div>
            <?php } ?>
        </div>
        <?php } ?>


    </section> <!-- /.content -->

     <?php
     // Popup peringatan stok habis & obat kedaluwarsa.
     //
     // Dulu hanya tampil untuk user_type 1 (superadmin), sehingga Owner
     // dan Pegawai tidak pernah diperingatkan. Padahal justru merekalah
     // yang melayani penjualan sehari-hari dan paling perlu tahu.
     //
     // Ikon lonceng/jam di header sudah menampilkan angka yang sama untuk
     // semua user, jadi isi popup ini bukan informasi baru - hanya cara
     // penyampaian yang lebih menonjol. Karena itu ditampilkan untuk semua
     // user yang sudah login.
     if($this->session->userdata('isLogIn'))
     {
     ?>
   <div id="stockmodal" class="modal fade" role="dialog">
     <div class="modal-dialog">
    <!-- Modal content-->
      <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo display('out_of_stock_and_date_expired_medicine')?></h4>
              </div>
      <div class="modal-body">
        <?php
         $date=date('Y-m-d');
     $this->db->select("b.*,b.expeire_date as expdate,a.product_name,a.strength,((select ifnull(sum(quantity),0) from product_purchase_details where product_id= `a`.`product_id`)-(select ifnull(sum(quantity),0) from invoice_details where product_id= `a`.`product_id`)) as 'stock'");
         $this->db->from('product_information a');
         $this->db->join('product_purchase_details b','b.product_id=a.product_id','left');
         $this->db->where('b.expeire_date <=', $date);
         $this->db->having('stock > 0');
         $this->db->group_by('b.batch_id');
         $this->db->group_by('a.product_id');
         $this->db->limit(20);
         $query = $this->db->get()->result_array();

        ?>
       <table id="" class="table table-bordered table-striped table-hover">
         <caption> <h4><center>Date Expired Medicine</center></h4></caption>
                                <thead>
                                    <tr>
                                        <th class="text-center"><?php echo display('product_name') ?></th>
                                        <th class="text-center"><?php echo display('batch_id') ?></th>
                                        <th class="text-center"><?php echo display('expeire_date') ?></th>
                                        
                                    </tr>
                                </thead>
                                <tbody>
                                <?php
                                    if ($query) {
                                        foreach ($query as $out) {
                                 
                                ?>
                               
                                    <tr>
                                      
                                        <td class="text-center">
                                            <a href="<?php echo base_url().'Cproduct/product_details/'.$out['product_id']; ?>">
                                           <?php echo html_escape($out['product_name'])?> 
                                            </a>    
                                        </td>
                                        <td class="text-center"> <?php echo html_escape($out['batch_id'])?> </td>
                                        <td class="text-center"><?php echo html_escape($out['expdate'])?>
                                     <input type="hidden" id="expdate" value="<?php echo html_escape($out['expdate'])?>">
                                         </td>
                                        
                                    </tr>
                             <?php     }
                             ?>
                                <?php
                                    }
                                ?>
                                </tbody>
                            </table>

                           <?php 
                           

     $this->db->select("a.*,b.manufacturer_name,a.product_name,a.generic_name,a.strength,((select ifnull(sum(quantity),0) from product_purchase_details where product_id= `a`.`product_id`)-(select ifnull(sum(quantity),0) from invoice_details where product_id= `a`.`product_id`)) as 'stock'");
         $this->db->from('product_information a');
          $this->db->join('manufacturer_information b','b.manufacturer_id=a.manufacturer_id','left');
         $this->db->having('stock < 10');
         $this->db->group_by('a.product_id');
         $this->db->order_by('a.product_name','asc');
         $this->db->limit(20);
        $out_of_stock = $this->db->get()->result_array();


                            ?>
        <table id="" class="table table-bordered table-striped table-hover">
             <caption> <h4><center>Out of Stock Medicine</center></h4></caption>
                                <thead>
                                    <tr>
                                        <th class="text-center"><?php echo display('product_name') ?></th>
                                        <th class="text-center"><?php echo display('product_type') ?></th>
                                        <th class="text-center"><?php echo display('unit') ?></th>
                                        <th class="text-center"><?php echo display('stock') ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php
                                        $spcount = 0;
                                        $count = 0;
                                    if ($out_of_stock) {
                                       
                                        foreach ($out_of_stock as $stockout) { 
                                            $count += $spcount;?>
                                       
                            
                                    <tr>
                                        
                                        <td class="text-center">
                                            <a href="<?php echo base_url().'Cproduct/product_details/'.$stockout['product_id']; ?>">
                                           <?php echo html_escape($stockout['product_name'])?> 
                                            </a> 
                                            <input type="hidden" id="stockqty" class="stockqtymdl" value="<?php echo html_escape($stockout['stock'])?>">   
                                        </td>
                                        <td class="text-center"><?php echo html_escape($stockout['product_model'])?> </td>
                                        <td class="text-center"><?php echo html_escape($stockout['unit'])?></td>
                                        <td class="text-center"><span class="text-danger"><?php echo html_escape($stockout['stock'])?></span></td>
                                    </tr>
                                <?php  $spcount++;}
                                ?>
                                <?php
                                    }
                                ?>
                                <input type="hidden" value="<?php echo  $count;?>" id="stpcount">
                                </tbody>
                            </table>
          </div>
          <div class="modal-footer">
            <input type="hidden" name="is_modal_shown" id="is_modal_shown" value="<?php echo $this->session->userdata('is_modal_shown');?>">
            <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo display('close')?></button>
          </div>
        </div>
     </div>
  </div>

     <?php } ?>

</div> <!-- /.content-wrapper -->
<!-- Admin Home end -->
 
<?php
// Chart.min.js dan canvasjs.min.js tidak dimuat lagi di sini:
//   - canvasjs (448 KB) tadinya hanya dipakai diagram lingkaran
//     Pendapatan/Pengeluaran yang sudah dihapus, jadi kini mubazir.
//   - Chart.min.js sudah dimuat oleh template admin, dan memuatnya
//     dua kali justru pernah membuat grafik rusak.
// dashboard.js tetap dipakai untuk datepicker filter dan popup
// peringatan stok habis / obat kedaluwarsa.
?>
<script src="<?php echo base_url() ?>assets/js/dashboard.js" type="text/javascript"></script>


