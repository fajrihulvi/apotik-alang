<!-- Log Perubahan Harga Jual -->
<div class="content-wrapper">
	<section class="content-header">
	    <div class="header-icon">
	        <i class="pe-7s-cash"></i>
	    </div>
	    <div class="header-title">
	        <h1><?php echo display('price_change_log') ?></h1>
	        <small><?php echo display('master_data') ?></small>
	        <ol class="breadcrumb">
	            <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
	            <li><a href="#"><?php echo display('master_data') ?></a></li>
	            <li class="active"><?php echo display('price_change_log') ?></li>
	        </ol>
	    </div>
	</section>

	<section class="content">

		<div class="row">
			<div class="col-sm-12">
				<div class="panel panel-bd lobidrag">
					<div class="panel-heading">
						<div class="panel-title">
							<h4><?php echo display('search') ?></h4>
						</div>
					</div>
					<div class="panel-body">
						<form method="get" action="<?php echo base_url('Cproduct/price_change_log') ?>" class="form-inline">
							<div class="form-group">
								<label><?php echo display('start_date') ?></label>
								<input type="date" name="from_date" class="form-control" value="<?php echo html_escape($filter['from_date']) ?>">
							</div>
							<div class="form-group">
								<label><?php echo display('end_date') ?></label>
								<input type="date" name="to_date" class="form-control" value="<?php echo html_escape($filter['to_date']) ?>">
							</div>
							<div class="form-group">
								<label><?php echo display('user') ?></label>
								<select name="user_id" class="form-control">
									<option value=""><?php echo display('all') ?></option>
									<?php foreach ($user_list as $u) { ?>
										<option value="<?php echo html_escape($u['user_id']) ?>" <?php echo ($filter['user_id'] == $u['user_id'] ? 'selected' : '') ?>>
											<?php echo html_escape(trim($u['nama_user'])) ?>
										</option>
									<?php } ?>
								</select>
							</div>
							<button type="submit" class="btn btn-success"><?php echo display('search') ?></button>
							<a href="<?php echo base_url('Cproduct/price_change_log') ?>" class="btn btn-default"><?php echo display('reset') ?></a>
						</form>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-sm-12">
				<div class="panel panel-bd lobidrag">
					<div class="panel-heading">
						<div class="panel-title">
							<h4><?php echo display('price_change_log') ?></h4>
						</div>
					</div>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-striped table-bordered" id="tabelLogHarga">
								<thead>
									<tr>
										<th><?php echo display('date') ?></th>
										<th><?php echo display('change_time') ?></th>
										<th><?php echo display('product_name') ?></th>
										<th class="text-right"><?php echo display('old_price') ?></th>
										<th class="text-right"><?php echo display('new_price') ?></th>
										<th><?php echo display('price_change_reason') ?></th>
										<th><?php echo display('changed_by') ?></th>
									</tr>
								</thead>
								<tbody>
								<?php if (!empty($log)) { foreach ($log as $r) {
									$naik = ((float)$r['harga_baru'] > (float)$r['harga_lama']);
								?>
									<tr>
										<td><?php echo html_escape($r['tanggal_tampil']) ?></td>
										<td><?php echo html_escape(substr($r['jam'],0,5)) ?></td>
										<td><?php echo html_escape(trim($r['nama_produk'].' '.$r['kekuatan'])) ?></td>
										<td class="text-right"><?php echo html_escape(number_format((float)$r['harga_lama'], 2, '.', ',')) ?></td>
										<td class="text-right" style="color:<?php echo ($naik ? '#3c763d' : '#a94442') ?>">
											<b><?php echo html_escape(number_format((float)$r['harga_baru'], 2, '.', ',')) ?></b>
										</td>
										<td><?php echo html_escape($r['alasan']) ?></td>
										<td><?php echo html_escape(trim($r['nama_user'])) ?></td>
									</tr>
								<?php } } else { ?>
									<tr><td colspan="7" class="text-center">-</td></tr>
								<?php } ?>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<script type="text/javascript">
$(document).ready(function(){
	if ($.fn.DataTable) {
		$('#tabelLogHarga').DataTable({
			"order": [],
			"pageLength": 25
		});
	}
});
</script>
