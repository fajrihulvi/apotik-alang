<!-- Stock List Start -->
<div class="content-wrapper">
	<section class="content-header">
	    <div class="header-icon">
	        <i class="pe-7s-note2"></i>
	    </div>
	    <div class="header-title">
	        <h1>Stok Kritis</h1>
	        <small>Stok Kritis</small>
	        <ol class="breadcrumb">
	            <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
	            <li><a href="#"><?php echo display('stock') ?></a></li>
	            <li class="active">Stok Kritis</li>
	        </ol>
	    </div>
	</section>

	<section class="content">


		<div class="row">
		    <div class="col-sm-12">
		        <div class="panel panel-bd lobidrag">
		            <div class="panel-heading">
		                <div class="panel-title">
		                    <h4>Stok Kritis</h4>
		                </div>
		            </div>
		            <div class="panel-body">

		                <?php
		                // Keterangan aturan. Dijelaskan di layar supaya pengguna
		                // tahu dari mana angka pembanding "Terjual" berasal dan
		                // apa beda label Kritis dengan Menipis.
		                ?>
		                <div class="csv-help" style="margin-bottom:15px;">
		                    <p style="margin-bottom:6px;">
		                        <span class="label" style="background:#d9534f;color:#fff;">
		                            <i class="fa fa-exclamation-triangle"></i> Kritis
		                        </span>
		                        &nbsp;stok sekarang <strong>lebih sedikit</strong> daripada jumlah terjual
		                        sepanjang <strong><?php echo html_escape($last_month_label)?></strong> (bulan lalu).
		                        Bila permintaan bulan ini serupa, stoknya tidak akan cukup.
		                        <?php if (!empty($criticalnumber)) { ?>
		                            Saat ini ada <strong><?php echo number_format($criticalnumber, 0, ',', '.')?></strong> obat
		                            dalam kondisi ini.
		                        <?php } ?>
		                    </p>
		                    <p style="margin-bottom:0;">
		                        <span class="label" style="background:#f0ad4e;color:#fff;">
		                            <i class="fa fa-clock-o"></i> Menipis
		                        </span>
		                        &nbsp;sisa stok di bawah 10, tetapi masih menutup penjualan bulan lalu.
		                    </p>
		                </div>

		                <?php
		                // Filter kolom Status. Tabel ini diproses di server,
		                // jadi penyaringan dikerjakan lewat query - bukan
		                // menyembunyikan baris di layar - supaya jumlah
		                // halaman dan totalnya ikut benar.
		                ?>
		                <div class="row" style="margin-bottom:12px;">
		                    <div class="col-sm-4">
		                        <div class="form-group" style="margin-bottom:0;">
		                            <label for="filter_stock_state">Status</label>
		                            <select id="filter_stock_state" class="form-control">
		                                <option value="">Semua</option>
		                                <option value="kritis">Kritis</option>
		                                <option value="menipis">Menipis</option>
		                            </select>
		                        </div>
		                    </div>
		                </div>

		                <div class="table-responsive">
		                    <table class="table table-striped table-bordered" cellspacing="0" width="100%" id="outof_stock">
		                        <thead>
									<tr>
										<th class="text-center"><?php echo display('sl') ?></th>
										<th class="text-center"><?php echo display('product_name') ?></th>
											<th class="text-center"><?php echo display('manufacturer_name') ?></th>

										<th class="text-center"><?php echo display('generic_name') ?></th>

										<th class="text-center"><?php echo display('stock') ?></th>
										<th class="text-center">Terjual <?php echo html_escape($last_month_label)?></th>
										<th class="text-center">Status</th>
									</tr>
								</thead>
								<tbody>

								</tbody>
		                    </table>
		                </div>

		                <div class="text-center">

		                </div>
		                <input type="hidden" name="" id="total_out_of_stock" value="<?php echo html_escape($totalnumber);?>">
		            </div>
		        </div>
		    </div>
		</div>
	</section>
</div>
