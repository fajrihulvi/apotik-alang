<!-- Log Stock Opname -->
<div class="content-wrapper">
	<section class="content-header">
	    <div class="header-icon">
	        <i class="pe-7s-note2"></i>
	    </div>
	    <div class="header-title">
	        <h1><?php echo display('opname_log') ?></h1>
	        <small><?php echo display('stock_opname') ?></small>
	        <ol class="breadcrumb">
	            <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
	            <li><a href="<?php echo base_url('Cstock_opname') ?>"><?php echo display('stock_opname') ?></a></li>
	            <li class="active"><?php echo display('opname_log') ?></li>
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
						<form method="get" action="<?php echo base_url('Cstock_opname/opname_log') ?>" class="form-inline">
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
							<div class="form-group">
								<label><?php echo display('opname_reason') ?></label>
								<select name="reason_code" class="form-control">
									<option value=""><?php echo display('all') ?></option>
									<?php foreach ($reason_list as $code => $phrase) { ?>
										<option value="<?php echo $code ?>" <?php echo ($filter['reason_code'] == $code ? 'selected' : '') ?>>
											<?php echo display($phrase) ?>
										</option>
									<?php } ?>
								</select>
							</div>
							<button type="submit" class="btn btn-success"><?php echo display('search') ?></button>
							<a href="<?php echo base_url('Cstock_opname/opname_log') ?>" class="btn btn-default"><?php echo display('reset') ?></a>
							<a href="<?php echo base_url('Cstock_opname/export_log_csv').'?'.http_build_query($filter) ?>" class="btn btn-info">
								<i class="fa fa-download"></i> CSV
							</a>
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
							<h4><?php echo display('opname_log') ?></h4>
						</div>
					</div>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-striped table-bordered" id="tabelLog">
								<thead>
									<tr>
										<th><?php echo display('date') ?></th>
										<th><?php echo display('adjusted_time') ?></th>
										<th><?php echo display('opname_no') ?></th>
										<th><?php echo display('product_name') ?></th>
										<th class="text-center"><?php echo display('unit') ?></th>
										<th class="text-right"><?php echo display('qty_system') ?></th>
										<th class="text-right"><?php echo display('qty_physical') ?></th>
										<th class="text-right"><?php echo display('qty_difference') ?></th>
										<th><?php echo display('opname_reason') ?></th>
										<th><?php echo display('adjusted_by') ?></th>
										<th><?php echo display('status') ?></th>
									</tr>
								</thead>
								<tbody>
								<?php if (!empty($log)) { foreach ($log as $r) { ?>
									<tr>
										<td><?php echo html_escape($r['tanggal_tampil']) ?></td>
										<td><?php echo html_escape(substr($r['jam'],0,5)) ?></td>
										<td>
											<a href="<?php echo base_url('Cstock_opname/opname_details/'.$r['opname_id']) ?>">
												<?php echo html_escape($r['no_opname']) ?>
											</a>
										</td>
										<td>
											<?php echo html_escape(trim($r['nama_produk'].' '.$r['kekuatan'])) ?>
											<?php if (!empty($r['keterangan'])) { ?>
												<br><small class="text-muted">&#8627; <?php echo html_escape($r['keterangan']) ?></small>
											<?php } ?>
										</td>
										<td class="text-center"><?php echo html_escape($r['satuan']) ?></td>
										<td class="text-right"><?php echo html_escape($r['stok_sebelum']) ?></td>
										<td class="text-right"><?php echo html_escape($r['stok_sesudah']) ?></td>
										<td class="text-right" style="color:<?php echo ($r['selisih'] < 0 ? '#a94442' : '#3c763d') ?>">
											<b><?php echo ($r['selisih'] > 0 ? '+' : '').html_escape($r['selisih']) ?></b>
										</td>
										<td><?php echo display('reason_'.$r['kode_alasan']) ?></td>
										<td><?php echo html_escape(trim($r['nama_user'])) ?></td>
										<td>
											<?php if ($r['status_opname'] == 1) { ?>
												<span class="label label-success"><?php echo display('opname_posted') ?></span>
											<?php } else { ?>
												<span class="label label-warning"><?php echo display('opname_draft') ?></span>
											<?php } ?>
										</td>
									</tr>
								<?php } } else { ?>
									<tr><td colspan="11" class="text-center">-</td></tr>
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
		$('#tabelLog').DataTable({
			"order": [],
			"pageLength": 25
		});
	}
});
</script>
