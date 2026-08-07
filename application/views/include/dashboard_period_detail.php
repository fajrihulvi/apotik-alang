<?php
// ==================================================================
// HALAMAN DETAIL RINGKASAN PERIODE
//
// Dibuka dari kartu ringkasan di dashboard. Menampilkan tiga bagian:
//   1. Kartu angka pokok periode berjalan
//   2. Breakdown per potongan waktu (tabel)
//   3. 10 barang paling laku
//
// Perhitungan angkanya dilakukan di model Reports, jadi angka di sini
// selalu sama dengan yang tampil di dashboard.
//
// Bagian breakdown dulu memakai grafik Chart.js, tapi terus bermasalah
// dan membuat halaman berat, jadi sekarang murni tabel. Perbandingan
// antar periode diwakili batang dari CSS biasa - tidak ada proses
// menggambar di browser, sehingga halaman ringan dan tidak bisa error.
// ==================================================================

// Format nominal mengikuti pengaturan mata uang di web_setting.
if (!function_exists('dashboard_money')) {
    function dashboard_money($amount, $currency, $position) {
        $value = number_format((float) $amount, 0, ',', '.');
        return ($position == 0 ? $currency.' '.$value : $value.' '.$currency);
    }
}

// Penentu apakah bagian breakdown perlu ditampilkan. Periode "hari
// ini" tidak dipecah lagi, jadi bagian ini disembunyikan di sana.
$has_breakdown = !empty($breakdown);
?>
<div class="content-wrapper">
    <section class="content-header">
        <div class="header-icon">
            <i class="pe-7s-graph1"></i>
        </div>
        <div class="header-title">
            <h1><?php echo html_escape($period_title)?></h1>
            <small>
                <?php echo date('d/m/Y', strtotime($from_date))?>
                <?php if ($from_date != $to_date) { ?>
                    s/d <?php echo date('d/m/Y', strtotime($to_date))?>
                <?php } ?>
            </small>
            <ol class="breadcrumb">
                <li><a href="<?php echo base_url('Admin_dashboard')?>"><i class="pe-7s-home"></i> <?php echo display('home')?></a></li>
                <li class="active"><?php echo html_escape($period_title)?></li>
            </ol>
        </div>
    </section>

    <section class="content">

        <!-- Pindah cepat antar periode tanpa harus kembali ke dashboard -->
        <div class="row">
            <div class="col-sm-12">
                <div class="btn-group dashboard-period-switch" role="group">
                    <?php
                    $switch = array(
                        'today' => 'Hari Ini',
                        'week'  => 'Minggu Ini',
                        'month' => 'Bulan Ini',
                        'year'  => 'Tahun Ini',
                    );
                    foreach ($switch as $key => $label) { ?>
                        <a href="<?php echo base_url('Admin_dashboard/period_detail/'.$key)?>"
                           class="btn <?php echo ($key == $period ? 'btn-primary active' : 'btn-default')?>">
                            <?php echo $label?>
                        </a>
                    <?php } ?>
                </div>
                <a href="<?php echo base_url('Admin_dashboard')?>" class="btn btn-default pull-right">
                    <i class="fa fa-arrow-left"></i> <?php echo display('dashboard')?>
                </a>
            </div>
        </div>

        <!-- Angka pokok periode.
             Bentuk kartunya mengikuti kartu ringkasan di dashboard:
             kelas kolom yang sama dan angka dibungkus .coundownnumber
             agar ukuran serta ketebalannya seragam di seluruh aplikasi. -->
        <?php
        $stat_boxes = array(
            array(
                'bg'    => 'bg-primary',
                'icon'  => 'fa-medkit',
                'value' => number_format($summary['total_qty'], 0, ',', '.'),
                'label' => 'Jumlah Obat Terjual',
            ),
            array(
                'bg'    => 'bg-green',
                'icon'  => 'fa-shopping-cart',
                'value' => dashboard_money($summary['total_sell'], $currency, $position),
                'label' => 'Jumlah Sell Price',
            ),
            array(
                'bg'    => 'bg-orange',
                'icon'  => 'fa-truck',
                'value' => dashboard_money($summary['total_cost'], $currency, $position),
                'label' => 'Jumlah Purchase Price',
            ),
            array(
                // Warna berubah merah bila rugi, supaya langsung terlihat.
                'bg'    => ($summary['gross_margin'] < 0 ? 'bg-danger' : 'bg-darkgreen'),
                'icon'  => 'fa-percent',
                'value' => dashboard_money($summary['gross_margin'], $currency, $position),
                'label' => 'Gross Margin ('.number_format($summary['margin_percent'], 2, ',', '.').'%)',
            ),
            array(
                'bg'    => 'bg-bringal',
                'icon'  => 'fa-users',
                'value' => number_format($summary['total_invoice'], 0, ',', '.'),
                'label' => 'Jumlah Pelanggan (Transaksi)',
            ),
            array(
                'bg'    => 'bg-pase',
                'icon'  => 'fa-user',
                'value' => number_format($summary['total_customer'], 0, ',', '.'),
                'label' => 'Pelanggan Terdaftar',
            ),
        );
        ?>
        <div class="row" style="margin-top:15px;">
            <?php foreach ($stat_boxes as $box) { ?>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-2">
                <div class="small-box <?php echo $box['bg']?> whitecolor">
                    <div class="inner">
                        <h4 class="text-center"><span class="coundownnumber dashboard-stat-value" title="<?php echo html_escape($box['value'])?>"><?php echo html_escape($box['value'])?></span></h4>

                        <p class="text-center"><?php echo html_escape($box['label'])?></p>
                    </div>
                    <div class="icon">
                        <i class="fa <?php echo $box['icon']?>"></i>
                    </div>
                </div>
            </div>
            <?php } ?>
        </div>

        <?php if ($has_breakdown) { ?>
        <!-- Breakdown per potongan waktu -->
        <div class="row">
            <div class="col-xs-12">
                <div class="panel panel-bd lobidisable">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <h4>
                                Breakdown
                                <?php
                                if ($period == 'week')      echo 'Per Hari';
                                elseif ($period == 'month') echo 'Per Minggu';
                                elseif ($period == 'year')  echo 'Per Bulan';
                                ?>
                            </h4>
                        </div>
                    </div>
                    <div class="panel-body">
                        <?php
                        // Penjualan tertinggi dipakai sebagai pembanding
                        // panjang batang perbandingan di tiap baris.
                        $max_sell = 0;
                        foreach ($breakdown as $row) {
                            if ($row['total_sell'] > $max_sell) {
                                $max_sell = $row['total_sell'];
                            }
                        }
                        ?>
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>Periode</th>
                                        <th class="text-right">Obat Terjual</th>
                                        <th class="text-right">Sell Price</th>
                                        <th class="text-right">Purchase Price</th>
                                        <th class="text-right">Gross Margin</th>
                                        <th class="text-right">%</th>
                                        <th class="text-right">Transaksi</th>
                                        <th class="breakdown-bar-col">Perbandingan Penjualan</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php foreach ($breakdown as $row) {
                                    // Batang dibuat dari CSS biasa (lebar dalam
                                    // persen), bukan grafik, sehingga tidak ada
                                    // proses menggambar di browser sama sekali.
                                    $bar = ($max_sell > 0 ? ($row['total_sell'] / $max_sell) * 100 : 0);
                                ?>
                                    <tr>
                                        <td><?php echo html_escape($row['label'])?></td>
                                        <td class="text-right"><?php echo number_format($row['total_qty'], 0, ',', '.')?></td>
                                        <td class="text-right"><?php echo dashboard_money($row['total_sell'], $currency, $position)?></td>
                                        <td class="text-right"><?php echo dashboard_money($row['total_cost'], $currency, $position)?></td>
                                        <td class="text-right <?php echo ($row['gross_margin'] < 0 ? 'text-danger' : '')?>">
                                            <?php echo dashboard_money($row['gross_margin'], $currency, $position)?>
                                        </td>
                                        <td class="text-right"><?php echo number_format($row['margin_percent'], 2, ',', '.')?>%</td>
                                        <td class="text-right"><?php echo number_format($row['total_invoice'], 0, ',', '.')?></td>
                                        <td class="breakdown-bar-col">
                                            <div class="breakdown-bar" title="<?php echo dashboard_money($row['total_sell'], $currency, $position)?>">
                                                <span style="width: <?php echo number_format($bar, 2, '.', '')?>%;"></span>
                                            </div>
                                        </td>
                                    </tr>
                                <?php } ?>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <th>Total</th>
                                        <th class="text-right"><?php echo number_format($summary['total_qty'], 0, ',', '.')?></th>
                                        <th class="text-right"><?php echo dashboard_money($summary['total_sell'], $currency, $position)?></th>
                                        <th class="text-right"><?php echo dashboard_money($summary['total_cost'], $currency, $position)?></th>
                                        <th class="text-right"><?php echo dashboard_money($summary['gross_margin'], $currency, $position)?></th>
                                        <th class="text-right"><?php echo number_format($summary['margin_percent'], 2, ',', '.')?>%</th>
                                        <th class="text-right"><?php echo number_format($summary['total_invoice'], 0, ',', '.')?></th>
                                        <th class="breakdown-bar-col"></th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <?php } ?>

        <!-- Top 10 barang paling laku -->
        <div class="row">
            <div class="col-xs-12">
                <div class="panel panel-bd lobidisable">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <h4><i class="fa fa-trophy"></i> Top 10 Barang Paling Laku</h4>
                        </div>
                    </div>
                    <div class="panel-body">
                        <?php if (!empty($top_products)) { ?>
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th class="text-center">#</th>
                                        <th><?php echo display('product_name')?></th>
                                        <th class="text-right">Jumlah Terjual</th>
                                        <th class="text-right">Sell Price</th>
                                        <th class="text-right">Purchase Price</th>
                                        <th class="text-right">Gross Margin</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php $no = 1; foreach ($top_products as $top) { ?>
                                    <tr>
                                        <td class="text-center"><?php echo $no++?></td>
                                        <td>
                                            <a href="<?php echo base_url('Cproduct/product_details/'.$top['product_id'])?>">
                                                <?php echo html_escape($top['product_name'])?>
                                            </a>
                                        </td>
                                        <td class="text-right"><?php echo number_format($top['total_qty'], 0, ',', '.')?></td>
                                        <td class="text-right"><?php echo dashboard_money($top['total_sell'], $currency, $position)?></td>
                                        <td class="text-right"><?php echo dashboard_money($top['total_cost'], $currency, $position)?></td>
                                        <td class="text-right <?php echo ($top['gross_margin'] < 0 ? 'text-danger' : '')?>">
                                            <?php echo dashboard_money($top['gross_margin'], $currency, $position)?>
                                        </td>
                                    </tr>
                                <?php } ?>
                                </tbody>
                            </table>
                        </div>
                        <?php } else { ?>
                        <p class="text-muted">Belum ada penjualan pada periode ini.</p>
                        <?php } ?>
                    </div>
                </div>
            </div>
        </div>

    </section>
</div>

