<!-- Form Stock Opname -->
<div class="content-wrapper">
	<section class="content-header">
	    <div class="header-icon">
	        <i class="pe-7s-note2"></i>
	    </div>
	    <div class="header-title">
	        <h1><?php echo display('add_stock_opname') ?></h1>
	        <small><?php echo display('stock_opname') ?></small>
	        <ol class="breadcrumb">
	            <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
	            <li><a href="<?php echo base_url('Cstock_opname') ?>"><?php echo display('stock_opname') ?></a></li>
	            <li class="active"><?php echo display('add_stock_opname') ?></li>
	        </ol>
	    </div>
	</section>

	<section class="content">
		<form id="opnameForm" method="post" action="<?php echo base_url('Cstock_opname/save_draft') ?>">
		<?php echo form_hidden($this->security->get_csrf_token_name(), $this->security->get_csrf_hash()); ?>

		<div class="row">
			<div class="col-sm-12">
				<div class="panel panel-bd lobidrag">
					<div class="panel-heading">
						<div class="panel-title">
							<h4><?php echo display('add_stock_opname') ?></h4>
						</div>
					</div>
					<div class="panel-body">

						<div class="row">
							<div class="col-sm-3">
								<div class="form-group">
									<label><?php echo display('opname_no') ?></label>
									<input type="text" class="form-control" value="<?php echo html_escape($opname_no) ?>" readonly>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label><?php echo display('date') ?></label>
									<input type="text" class="form-control" value="<?php echo html_escape($opname_date) ?>" readonly>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label><?php echo display('adjusted_time') ?></label>
									<input type="text" class="form-control" value="<?php echo html_escape($opname_time) ?>" readonly>
								</div>
							</div>
							<div class="col-sm-5">
								<div class="form-group">
									<label><?php echo display('opname_note') ?></label>
									<input type="text" name="note" class="form-control" placeholder="<?php echo display('opname_note') ?>">
								</div>
							</div>
						</div>

						<hr>

						<div class="row">
							<div class="col-sm-5">
								<div class="form-group">
									<label><?php echo display('product_name') ?></label>
									<input type="text" id="cariProduk" class="form-control" autocomplete="off" placeholder="<?php echo display('search') ?> <?php echo display('product_name') ?>...">
									<small class="text-muted"><?php echo display('product_name') ?> &rarr; <?php echo display('add_stock_opname') ?></small>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="form-group">
									<label><?php echo display('manufacturer_name') ?></label>
									<select id="filterDistributor" class="form-control">
										<option value=""><?php echo display('all') ?></option>
										<?php foreach ($manufacturers as $m) { ?>
											<option value="<?php echo html_escape($m['manufacturer_id']) ?>"><?php echo html_escape($m['manufacturer_name']) ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group">
									<label>&nbsp;</label><br>
									<button type="button" id="btnMuat" class="btn btn-primary"><i class="fa fa-list"></i> <?php echo display('all') ?></button>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-sm-12">
				<div class="panel panel-bd lobidrag">
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-striped table-bordered" id="tabelOpname">
								<thead>
									<tr>
										<th style="width:35%"><?php echo display('product_name') ?></th>
										<th class="text-center" style="width:10%"><?php echo display('unit') ?></th>
										<th class="text-right" style="width:10%"><?php echo display('qty_system') ?></th>
										<th class="text-right" style="width:10%"><?php echo display('qty_physical') ?></th>
										<th class="text-right" style="width:8%"><?php echo display('qty_difference') ?></th>
										<th style="width:12%"><?php echo display('opname_reason') ?></th>
										<th style="width:15%"><?php echo display('reason_note') ?></th>
									</tr>
								</thead>
								<tbody id="isiTabel">
									<tr id="barisKosong">
										<td colspan="7" class="text-center text-muted">
											<?php echo display('search') ?> <?php echo display('product_name') ?> &mdash; <?php echo display('manufacturer_name') ?>
										</td>
									</tr>
								</tbody>
								<tfoot>
									<tr>
										<th colspan="4" class="text-right"><?php echo display('total_item') ?> / <?php echo display('qty_difference') ?>:</th>
										<th class="text-right" id="totalSelisih">0</th>
										<th colspan="2" id="ringkasan"></th>
									</tr>
								</tfoot>
							</table>
						</div>

						<div class="row" style="margin-top:15px;">
							<div class="col-sm-12 text-right">
								<a href="<?php echo base_url('Cstock_opname') ?>" class="btn btn-default"><?php echo display('cancel') ?></a>
								<button type="submit" id="btnDraft" class="btn btn-warning"><?php echo display('save_draft') ?></button>
								<button type="button" id="btnPosting" class="btn btn-success"><?php echo display('post_opname') ?></button>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
		</form>
	</section>
</div>

<script type="text/javascript">
(function(){
	var baseUrl = "<?php echo base_url() ?>";

	// Opsi alasan, dipakai saat membuat baris baru
	var reasonOptions = '<option value=""></option>'
		<?php foreach ($reason_list as $code => $phrase) { ?>
		+ '<option value="<?php echo $code ?>"><?php echo html_escape(display($phrase)) ?></option>'
		<?php } ?>;

	function angka(v){ var n = parseFloat(v); return isNaN(n) ? 0 : n; }
	function esc(v){ return $('<div>').text(v == null ? '' : v).html(); }

	// Hitung ulang selisih tiap baris + ringkasan bawah
	function hitung(){
		var totalSelisih = 0, jumlahItem = 0, adaBaris = false;
		$('#isiTabel tr[data-produk]').each(function(){
			adaBaris = true;
			var $b     = $(this);
			var sistem = angka($b.data('sistem'));
			var fisikR = $b.find('.qty-fisik').val();
			var $sel   = $b.find('.sel-nilai');
			var $alasan= $b.find('.pilih-alasan');

			if (fisikR === '' || fisikR === null) {
				$sel.text('-').css('color','');
				$alasan.prop('required', false);
				return;
			}

			var selisih = angka(fisikR) - sistem;
			$sel.text(selisih > 0 ? '+' + selisih : selisih);
			$sel.css('color', selisih < 0 ? '#a94442' : (selisih > 0 ? '#3c763d' : ''));

			// Alasan wajib diisi hanya bila ada selisih
			$alasan.prop('required', selisih !== 0);

			if (selisih !== 0) { totalSelisih += selisih; jumlahItem++; }
		});
		$('#totalSelisih').text(totalSelisih > 0 ? '+' + totalSelisih : totalSelisih);
		$('#ringkasan').text(jumlahItem + ' item');
		if (!adaBaris && $('#isiTabel #barisKosong').length === 0) {
			$('#isiTabel').html('<tr id="barisKosong"><td colspan="7" class="text-center text-muted">-</td></tr>');
		}
	}

	// Bangun satu baris produk (dipakai autocomplete & muat-semua)
	function baris(r){
		return '<tr data-produk="' + esc(r.product_id) + '" data-sistem="' + angka(r.stock) + '">'
			 +   '<td>' + esc((r.product_name || '') + ' ' + (r.strength || ''))
			 +     '<input type="hidden" name="product_id[]" value="' + esc(r.product_id) + '">'
			 +   '</td>'
			 +   '<td class="text-center">' + esc(r.unit) + '</td>'
			 +   '<td class="text-right">' + angka(r.stock) + '</td>'
			 +   '<td><input type="number" step="any" min="0" class="form-control input-sm text-right qty-fisik" name="qty_physical[]"></td>'
			 +   '<td class="text-right sel-nilai">-</td>'
			 +   '<td><select class="form-control input-sm pilih-alasan" name="reason_code[]">' + reasonOptions + '</select></td>'
			 +   '<td>'
			 +     '<div class="input-group">'
			 +       '<input type="text" class="form-control input-sm" name="reason_note[]">'
			 +       '<span class="input-group-btn"><button type="button" class="btn btn-danger btn-sm hapus-baris" title="&times;">&times;</button></span>'
			 +     '</div>'
			 +   '</td>'
			 + '</tr>';
	}

	// Tambah satu produk (dari autocomplete). Cegah duplikat.
	function tambahProduk(r){
		if (!r || !r.product_id) { return; }
		if ($('#isiTabel tr[data-produk="' + $.escapeSelector(String(r.product_id)) + '"]').length) {
			// sudah ada -> sorot sebentar
			$('#isiTabel tr[data-produk="' + $.escapeSelector(String(r.product_id)) + '"]')
				.find('.qty-fisik').focus();
			return;
		}
		$('#isiTabel #barisKosong').remove();
		$('#isiTabel').append(baris(r));
		hitung();
	}

	// Muat SEMUA produk (opsional, tombol di kanan)
	function muatSemua(){
		$.getJSON(baseUrl + 'Cstock_opname/search_product', {
			keyword: '',
			manufacturer_id: $('#filterDistributor').val()
		}, function(rows){
			if (!rows || rows.length === 0) { return; }
			$('#isiTabel #barisKosong').remove();
			var html = '';
			$.each(rows, function(i, r){
				if ($('#isiTabel tr[data-produk="' + $.escapeSelector(String(r.product_id)) + '"]').length) { return; }
				html += baris(r);
			});
			$('#isiTabel').append(html);
			hitung();
		});
	}

	// --- Autocomplete Nama Obat (jQuery UI) ---
	// PENTING: jquery-ui.min.js dimuat di FOOTER template, setelah view ini
	// di-render. Jadi $.fn.autocomplete belum tentu ada saat skrip ini jalan.
	// initAutocomplete() dipanggil setelah window load; kalau plugin masih
	// belum siap, ia menunggu sebentar lalu mencoba lagi.
	function initAutocomplete(percobaan){
		percobaan = percobaan || 0;
		if (!$.fn || !$.fn.autocomplete) {
			if (percobaan < 40) { setTimeout(function(){ initAutocomplete(percobaan + 1); }, 100); }
			return;
		}

		$('#cariProduk').autocomplete({
			minLength: 1,
			delay: 200,
			source: function(request, response){
				$.getJSON(baseUrl + 'Cstock_opname/search_product', {
					keyword: request.term,
					manufacturer_id: $('#filterDistributor').val()
				}, function(rows){
					if (!rows || rows.length === 0) {
						response([{ label: '<?php echo html_escape(display('no_data_available') ?: 'No data') ?>', value: '', kosong: true }]);
						return;
					}
					response($.map(rows, function(r){
						var label = (r.product_name || '') + ' ' + (r.strength || '');
						label += '  —  ' + (r.manufacturer_name || '') + '  —  ' + '<?php echo html_escape(display('stock')) ?>: ' + angka(r.stock);
						return { label: label.trim(), value: r.product_name, data: r };
					}));
				});
			},
			focus: function(e, ui){ return false; },   // jangan tulis ke input saat hover
			select: function(e, ui){
				if (ui.item && !ui.item.kosong) {
					tambahProduk(ui.item.data);
				}
				$('#cariProduk').val('');
				return false;
			}
		});
	}
	$(window).on('load', function(){ initAutocomplete(); });

	$('#btnMuat').on('click', muatSemua);

	// Enter di kotak cari jangan submit form
	$('#cariProduk').on('keydown', function(e){
		if (e.which === 13) { e.preventDefault(); }
	});

	// Hitung ulang saat stok fisik diketik; hapus baris
	$('#isiTabel').on('input change', '.qty-fisik', hitung);
	$('#isiTabel').on('click', '.hapus-baris', function(){
		$(this).closest('tr').remove();
		hitung();
	});

	// Cegah simpan bila belum ada baris sama sekali
	function adaBarisProduk(){ return $('#isiTabel tr[data-produk]').length > 0; }

	$('#opnameForm').on('submit', function(e){
		if (!adaBarisProduk()) {
			e.preventDefault();
			alert('<?php echo html_escape(display('search') ?: 'Pilih') ?> <?php echo html_escape(display('product_name')) ?>');
		}
	});

	// Posting: ubah action lalu submit
	$('#btnPosting').on('click', function(){
		var form = document.getElementById('opnameForm');
		if (!adaBarisProduk()) {
			alert('<?php echo html_escape(display('search') ?: 'Pilih') ?> <?php echo html_escape(display('product_name')) ?>');
			return;
		}
		if (!form.checkValidity()) { form.reportValidity(); return; }
		form.action = baseUrl + 'Cstock_opname/save_and_post';
		form.submit();
	});
})();
</script>
