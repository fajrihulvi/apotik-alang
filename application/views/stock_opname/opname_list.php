<!-- Daftar Stock Opname -->
<div class="content-wrapper">
	<section class="content-header">
	    <div class="header-icon">
	        <i class="pe-7s-note2"></i>
	    </div>
	    <div class="header-title">
	        <h1><?php echo display('opname_list') ?></h1>
	        <small><?php echo display('stock_opname') ?></small>
	        <ol class="breadcrumb">
	            <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
	            <li><a href="#"><?php echo display('stock') ?></a></li>
	            <li class="active"><?php echo display('opname_list') ?></li>
	        </ol>
	    </div>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-sm-12">
				<div class="panel panel-bd lobidrag">
					<div class="panel-heading">
						<div class="panel-title">
							<h4><?php echo display('opname_list') ?></h4>
						</div>
						<div class="btn-group pull-right" style="margin-top:-32px;">
							<a href="<?php echo base_url('Cstock_opname/opname_form') ?>" class="btn btn-primary">
								<i class="fa fa-plus"></i> <?php echo display('add_stock_opname') ?>
							</a>
							<a href="<?php echo base_url('Cstock_opname/opname_log') ?>" class="btn btn-info">
								<i class="fa fa-history"></i> <?php echo display('opname_log') ?>
							</a>
						</div>
					</div>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-striped table-bordered" id="tabelDaftarOpname">
								<thead>
									<tr>
										<th><?php echo display('opname_no') ?></th>
										<th><?php echo display('date') ?></th>
										<th><?php echo display('adjusted_time') ?></th>
										<th class="text-right"><?php echo display('total_item') ?></th>
										<th class="text-right"><?php echo display('qty_difference') ?></th>
										<th><?php echo display('adjusted_by') ?></th>
										<th><?php echo display('status') ?></th>
										<th class="text-center"><?php echo display('action') ?></th>
									</tr>
								</thead>
								<tbody>
								<?php if (!empty($opname_list)) { foreach ($opname_list as $row) { ?>
									<tr>
										<td><?php echo html_escape($row['opname_no']) ?></td>
										<td><?php echo html_escape($row['tanggal_tampil']) ?></td>
										<td><?php echo html_escape(substr($row['opname_time'],0,5)) ?></td>
										<td class="text-right"><?php echo html_escape($row['total_item']) ?></td>
										<td class="text-right" style="color:<?php echo ($row['total_selisih'] < 0 ? '#a94442' : ($row['total_selisih'] > 0 ? '#3c763d' : '')) ?>">
											<?php echo ($row['total_selisih'] > 0 ? '+' : '').html_escape($row['total_selisih']) ?>
										</td>
										<td><?php echo html_escape(trim($row['nama_user'])) ?></td>
										<td>
											<?php if ($row['status'] == 1) { ?>
												<span class="label label-success"><?php echo display('opname_posted') ?></span>
											<?php } else { ?>
												<span class="label label-warning"><?php echo display('opname_draft') ?></span>
											<?php } ?>
										</td>
										<td class="text-center">
											<a href="<?php echo base_url('Cstock_opname/opname_details/'.$row['id']) ?>" class="btn btn-info btn-sm">
												<i class="fa fa-eye"></i> <?php echo display('details') ?>
											</a>
											<?php if ($row['status'] == 0) { ?>
												<a href="<?php echo base_url('Cstock_opname/delete_draft/'.$row['id']) ?>"
												   class="btn btn-danger btn-sm"
												   onclick="return confirm('<?php echo display('delete') ?>?')">
													<i class="fa fa-trash"></i>
												</a>
											<?php } ?>
										</td>
									</tr>
								<?php } } else { ?>
									<tr><td colspan="8" class="text-center">-</td></tr>
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
		$('#tabelDaftarOpname').DataTable({
			"order": [[ 0, "desc" ]],
			"columnDefs": [{ "orderable": false, "targets": [7] }]
		});
	}
});
</script>
