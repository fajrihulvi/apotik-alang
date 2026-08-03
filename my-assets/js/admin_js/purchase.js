"use strict";   
function product_pur_or_list(sl) {

     var csrf_test_name = $('[name="csrf_test_name"]').val();
            var base_url = $('#base_url').val();

    // Auto complete, daftar obat tidak difilter berdasarkan distributor
    var options = {
        minLength: 0,
        source: function( request, response ) {
            var product_name = $('#product_name_'+sl).val();
        $.ajax( {
          url: base_url + "Cpurchase/product_search_by_manufacturer",
          method: 'post',
          dataType: "json",
          data: {
            term: request.term,
            product_name:product_name,csrf_test_name:csrf_test_name
          },
          success: function( data ) {
            response( data );

          }
        });
      },
       focus: function( event, ui ) {
           $(this).val(ui.item.label);
           return false;
       },
       select: function( event, ui ) {
            $(this).parent().parent().find(".autocomplete_hidden_value").val(ui.item.value); 
            var sl = $(this).parent().parent().find(".sl").val(); 

            var product_id          = ui.item.value;

            var base_url    = $('.baseUrl').val();


            var available_quantity    = 'available_quantity_'+sl;
            var product_rate    = 'product_rate_'+sl;

           
         
         
            $.ajax({
                type: "POST",
                url: base_url+"Cinvoice/retrieve_product_data",
                 data: {product_id:product_id,csrf_test_name:csrf_test_name},
                cache: false,
                success: function(data)
                {
                    console.log(data);
                   var obj = JSON.parse(data);
                   $('#'+available_quantity).val(obj.total_product);
                    $('#'+product_rate).val(obj.manufacturer_price);
                  
                } 
            });

            $(this).unbind("change");
            return false;
       }
   }

   $('body').on('keypress.autocomplete', '.product_name', function() {
       $(this).autocomplete(options);
   });

}

      "use strict";
    function addPurchaseOrderField1(divName){

  
            var row = $("#purchaseTable tbody tr").length;
            var count = row + 1;
            var newdiv = document.createElement('tr');
            var tabin="product_name_"+count,
             tabindex = count * 7,
           newdiv = document.createElement("tr"),
            tab1 = tabindex + 1,
            
            tab2 = tabindex + 2,
            tab3 = tabindex + 3,
            tab4 = tabindex + 4,
            tab5 = tabindex + 5,
            tab6 = tabindex + 6,
            tab7 = tabindex + 7,
            tab8 = tab7 + 1;
           
            newdiv.innerHTML ='<td class="span3 manufacturer"><input type="text" name="product_name"  class="form-control product_name productSelection" onkeypress="product_pur_or_list('+ count +')" placeholder="Medicine Name" id="product_name_'+ count +'" tabindex="'+tab1+'" required> <input type="hidden" class="autocomplete_hidden_value product_id_'+ count +'" name="product_id[]" id="SchoolHiddenId"/>  <input type="hidden" class="sl" value="'+ count +'">  </td> <td> <input type="text" required="required" name="batch_id[]" id="batch_id_'+ count +'" tabindex="'+tab2+'" class="form-control text-right"  tabindex="11" placeholder="Batch Id" /></td><td><input type="text" name="expeire_date[]" onchange="checkExpiredate('+ count +')" id="expeire_date_'+ count +'" required="required" class="form-control datepicker" tabindex="'+tab3+'"  placeholder="Expire Date"/> </td>  <td class="wt"> <input type="text" id="available_quantity_'+ count +'" class="form-control text-right stock_ctn_'+ count +'" placeholder="0.00" readonly/> </td><td class="text-right"><input type="text" name="product_quantity[]" tabindex="'+tab4+'" required  id="quantity_'+ count +'" class="form-control text-right store_cal_' + count + '" onkeyup="calculate_store(' + count + '),checkqty(' + count + ');" onchange="calculate_store(' + count + ');" placeholder="0.00" value="" min="0"/>  </td><td class="test"><input type="text" name="product_rate[]"  required onkeyup="calculate_store('+ count +'),checkqty(' + count + ');" onchange="calculate_store('+ count +');" id="product_rate_'+ count +'" class="form-control product_rate_'+ count +' text-right" placeholder="0.00" value="" min="0" tabindex="'+tab5+'"/></td><td class="text-right"><input type="text" name="discount[]" onkeyup="calculate_store('+ count +');" onchange="calculate_store('+ count +');" id="discount_'+ count +'" class="form-control discount_'+ count +' text-right" placeholder="0.00" value="0" min="0" max="100" tabindex="'+tab6+'"/></td><td class="text-right"><input class="form-control total_price text-right total_price_'+ count +'" type="text" name="total_price[]" id="total_price_'+ count +'" value="0.00" readonly="readonly" /><input type="hidden" class="discount_amount" id="discount_amount_'+ count +'" value="0"/> </td><td> <button type="button" class="btn btn-danger" tabindex="'+tab7+'" onclick="deleteRow(this)"><i class="fa fa-close"></i></button></td>';
            document.getElementById(divName).appendChild(newdiv);
            document.getElementById(tabin).focus();
            // tab7 sudah dipakai tombol hapus baris, jadi tombol tambah &
            // simpan memakai slot sesudahnya.
            document.getElementById("add_invoice_item").setAttribute("tabindex", tab8);
            document.getElementById("add_purchase").setAttribute("tabindex", tab8 + 1);
        
           
            count++;
$(".datepicker").datepicker({ dateFormat:'yy-mm-dd' });
            $("select.form-control:not(.dont-select-me)").select2({
                placeholder: "Select option",
                allowClear: true
            });
       
    }

    //Calculate store product
    "use strict";
    function calculate_store(sl) {
       
        var gr_tot = 0;
        var gr_disc = 0;
        var item_ctn_qty    = parseFloat($("#quantity_"+sl).val()) || 0;
        var vendor_rate = parseFloat($("#product_rate_"+sl).val()) || 0;

        // Diskon per barang dalam persen, dibatasi 0-100.
        var discount_percent = parseFloat($("#discount_"+sl).val()) || 0;
        if (discount_percent < 0) { discount_percent = 0; }
        if (discount_percent > 100) {
            discount_percent = 100;
            $("#discount_"+sl).val(100);
        }

        var sub_total       = item_ctn_qty * vendor_rate;
        var discount_amount = sub_total * discount_percent / 100;
        // Total sudah dikurangi diskon.
        var total_price     = sub_total - discount_amount;

        $("#total_price_"+sl).val(total_price.toFixed(2));
        $("#discount_amount_"+sl).val(discount_amount.toFixed(2));

        //Total Price
        $("#purchaseTable .total_price").each(function() {
            isNaN(this.value) || 0 == this.value.length || (gr_tot += parseFloat(this.value))
        });

        //Total diskon seluruh barang
        $("#purchaseTable .discount_amount").each(function() {
            isNaN(this.value) || 0 == this.value.length || (gr_disc += parseFloat(this.value))
        });

        $("#grandTotal").val(gr_tot.toFixed(2));
        $("#total_discount").val(gr_disc.toFixed(2));
    }

      "use strict";
      function checkExpiredate(sl) {
        var purdates =  $("#purdate").val();
        var expiredate = $("#expeire_date_"+sl).val();
        var purchasedate = new Date(purdates);
        var expirydate = new Date(expiredate);
        if (expirydate <= purchasedate ) { 
            alert('Expiry Date Should Be Greater than Purchase Date');
          document.getElementById("expeire_date_"+sl).value = '';
            return false;
        }
        return true;
    }


     "use strict";
     function checkqty(sl)
{
  
  var y=$("#quantity_"+sl).val();
  var x=$("#product_rate_"+sl).val();
  if (isNaN(y)){
    alert("Must Input Number");
    document.getElementById("quantity_"+sl).value = '';
    return false;
  }
  if (isNaN(x)) 
  {
    alert("Must Input Number");
     document.getElementById("product_rate_"+sl).value = '';
    return false;
  }
}
    //Calcucate Invoice Add Items
    "use strict";
    function quantity_calculate(item)
    {
        var qnty =$("#total_qntt_"+item).val();
        var rate =$("#price_item_"+item).val();

        var total_amnt = qnty * rate;
        $("#total_price_"+item).val(total_amnt);
        calculateSum();
    }

    //Calculate summation 
    "use strict";
    function calculateSum() {

    var t = 0,
        a = 0,
        e = 0,
        o = 0,
        p = 0;

        //Total Discount
        $(".total_discount").each(function() {
            isNaN(this.value) || 0 == this.value.length || (p += parseFloat(this.value))
        }), 
        
        $("#total_discount_ammount").val(p.toFixed(2,2)), 

        //Total Price
        $(".total_price").each(function() {
            isNaN(this.value) || 0 == this.value.length || (t += parseFloat(this.value))
        }), 
     
        e = t.toFixed(2,2);
        f = p.toFixed(2,2);

        var test = +e+ -f;
        $("#grandTotal").val(test.toFixed(2,2));
    }
        
    //Qnty calculate
    $("body").on("keyup change", ".qty_calculate", function() {
        var item    = $(this).val();
        var price   = $(this).parent().next().children().val();
        var discount = $(this).parent().next().next().children().val();
        var all_discount = $(this).parent().next().next().next().next().children().next();
        var dis_type = $(this).parent().next().next().children().next().val();

        if (item > 0) {
            if (dis_type == 1) {
                var total_price = item * price;

                // Discount cal per product
                var dis   = total_price * discount / 100;
                all_discount.val(dis);

                //Total price calculate per product
                var temp = total_price - dis;
                $(this).parent().next().next().next().children().val(total_price);

            }else if(dis_type == 2){

                var total_price = item * price;

                // Discount cal per product
                var dis   = discount * item;
                all_discount.val(dis);

                //Total price calculate per product
                var temp = total_price - dis;
                $(this).parent().next().next().next().children().val(total_price);

            }else if(dis_type == 3){
                var total_price = item * price;

                // Discount cal per product
                all_discount.val(discount);

                //Total price calculate per product
                var temp   = total_price - discount;
                $(this).parent().next().next().next().children().val(total_price);
            }
        }else {
            var total_price = item * price;
            $(this).parent().next().next().next().children().val(total_price);
        }
        calculateSum();
    });  

    //Qnty calculate by rate
    $("body").on("keyup change", ".qty_calculate_rate", function() {
        var price   = $(this).val();
        var item    = $(this).parent().prev().children().val();

        var discount = $(this).parent().next().children().val();
        var dis_type = $(this).parent().next().children().next().val();
        var all_discount = $(this).parent().next().next().next().children().next();

        if (item > 0) {
            if (dis_type == 1) {
                var total_price = item * price;

                // Discount cal per product
                var dis   = total_price * discount / 100;
                all_discount.val(dis);

                //Total price calculate per product
                var temp = total_price - dis;
                $(this).parent().next().next().children().val(total_price);

            }else if(dis_type == 2){
                var total_price = item * price;

                // Discount cal per product
                var dis   = discount * item;
                all_discount.val(dis);

                //Total price calculate per product
                var temp = total_price - dis;
                $(this).parent().next().next().children().val(total_price);

            }else if(dis_type == 3){
                var total_price = item * price;

                // Discount cal per product
                all_discount.val(discount);

                //Total price calculate per product
                var temp   = total_price - discount;
                $(this).parent().next().next().children().val(total_price);
            }
        }else {
            var total_price = item * price;
            $(this).parent().next().next().children().val(total_price);
        }
        calculateSum();
    });


    //Qnty calculate by discount
    $("body").on("keyup change", ".qty_calculate_discount", function() {
        var discount     = $(this).val();
        var item         = $(this).parent().prev().prev().children().val();

        var price        = $(this).parent().prev().children().val();
        var dis_type     = $(this).next().val();
        var all_discount = $(this).parent().next().next().children().next();

        if (item > 0) {
            if (dis_type == 1) {
                var total_price = item * price;

                // Discount cal per product
                var dis   = total_price * discount / 100;
                all_discount.val(dis);

                //Total price calculate per product
                var temp = total_price - dis;
                $(this).parent().next().children().val(total_price);

            }else if(dis_type == 2){
                var total_price = item * price;

                // Discount cal per product
                var dis   = discount * item;
                all_discount.val(dis);

                //Total price calculate per product
                var temp = total_price - dis;
                $(this).parent().next().children().val(total_price);

            }else if(dis_type == 3){
                var total_price = item * price;

                // Discount cal per product
                all_discount.val(discount);

                //Total price calculate per product
                var temp   = total_price - discount;
                $(this).parent().next().children().val(total_price);
            }
        }else {
            var total_price = item * price;
            $(this).parent().next().children().val(total_price);
        }
        calculateSum();
    });
    
    //Quantity calculate
    $("body").on("keyup change", ".quantity_calculate", function() {
        var qnty   = $(this).parent().parent().children().next().children().val();
        var rate   = $(this).parent().parent().children().next().next().children().val();
        $(this).parent().parent().children().next().next().next().next().children().val(qnty * rate);
        calculateSum();
    });

    //Delete row
    "use strict";
    function deleteRow(e) {
        var t = $("#purchaseTable > tbody > tr").length;
        if (1 == t) alert("There only one row you can't delete.");
        else {
            var a = e.parentNode.parentNode;
            a.parentNode.removeChild(a)
        }
        // Hitung ulang grand total & total diskon setelah baris dihapus.
        recalculate_purchase_total()
    }

    // Jumlahkan ulang seluruh baris tabel pembelian.
    "use strict";
    function recalculate_purchase_total() {
        var gr_tot = 0;
        var gr_disc = 0;

        $("#purchaseTable .total_price").each(function() {
            isNaN(this.value) || 0 == this.value.length || (gr_tot += parseFloat(this.value))
        });

        $("#purchaseTable .discount_amount").each(function() {
            isNaN(this.value) || 0 == this.value.length || (gr_disc += parseFloat(this.value))
        });

        $("#grandTotal").val(gr_tot.toFixed(2));
        $("#total_discount").val(gr_disc.toFixed(2));
    }

    // Cadangan bila atribut onkeyup/onchange pada baris tidak terpasang
    // (mis. baris hasil template parser). Nomor baris diambil dari input .sl
    // pada baris yang sama, jadi tetap akurat walau urutan berubah.
    $("body").on("keyup change input", "#purchaseTable input[name='discount[]']", function() {
        var sl = $(this).closest("tr").find(".sl").val();
        if (typeof sl !== "undefined" && sl !== "") {
            calculate_store(sl);
        }
    });

    // Hitung ulang saat halaman dibuka, supaya baris yang sudah tersimpan
    // (form edit) langsung menampilkan total & diskon yang benar.
    $(function() {
        if ($("#purchaseTable").length) {
            $("#purchaseTable .sl").each(function() {
                calculate_store($(this).val());
            });
        }
    });

    $(document).ready(function() { 
        "use strict";
      var csrf_test_name = $('[name="csrf_test_name"]').val();
     var total_purchase_no = $("#total_purchase_no").val();
     var base_url = $("#base_url").val();
       var currency = $("#currency").val();
 var mydatatable = $('#PurList').DataTable({ 
             responsive: true,

             "aaSorting": [[4, "desc" ]],
             "columnDefs": [
                { "bSortable": false, "aTargets": [0,1,2,3,5,6,7,8,9,10,11,12,13,14] },
                // Kolom Aksi & Status jangan disembunyikan mode responsive
                // saat tabel melebar (responsivePriority makin kecil = makin
                // diprioritaskan untuk tetap tampil).
                { "responsivePriority": 1, "targets": 14 },
                { "responsivePriority": 2, "targets": 13 },
                { "responsivePriority": 3, "targets": 0 },

            ],
           'processing': true,
           'serverSide': true,

          
           'lengthMenu':[[10, 25, 50,100,250,500, total_purchase_no], [10, 25, 50,100,250,500, "All"]],

             dom:"'<'col-sm-4'l><'col-sm-4 text-center'><'col-sm-4'>Bfrtip", buttons:[ {
                extend: "copy",exportOptions: {
                       columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ] //Your Colume value those you want
                           }, className: "btn-sm prints"
            }
            , {
                extend: "csv", title: "PurchaseLIst",exportOptions: {
                       columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ] //Your Colume value those you want
                           }, className: "btn-sm prints"
            }
            , {
                extend: "excel",exportOptions: {
                       columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ] //Your Colume value those you want
                           }, className: "btn-sm prints"
            }
            , {
                extend: "pdf",exportOptions: {
                       columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ] //Your Colume value those you want
                           }, className: "btn-sm prints"
            }
            , {
                extend: "print",exportOptions: {
                       columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ] //Your Colume value those you want
                           }, className: "btn-sm prints"
            }
            ],

            
           'serverMethod': 'post',
            'ajax': {
               'url':base_url + 'Cpurchase/CheckPurchaseList',
                 "data": function ( data) {
         data.fromdate = $('#from_date').val();
         data.todate = $('#to_date').val();
         data.csrf_test_name = csrf_test_name;
        
}
            },
          'columns': [
             { data: 'sl' },
             { data: 'chalan_no'},
             { data: 'purchase_id'},
             { data: 'manufacturer_name'},
             { data: 'purchase_date' },
             { data: 'product_name'},
             { data: 'batch_id'},
             { data: 'expeire_date', class:"text-center"},
             { data: 'product_qty', class:"text-right"},
             { data: 'product_rate', class:"text-right"},
             { data: 'product_discount', class:"text-right"},
             { data: 'product_total', class:"text-right"},
             { data: 'total_amount',class:"total_sale text-right",render: $.fn.dataTable.render.number( ',', '.', 2, currency ) },
             { data: 'status', class:"text-center"},
             { data: 'button'},
          ],

  "footerCallback": function(row, data, start, end, display) {
  var api = this.api();
   api.columns('.total_sale', {
    page: 'current'
  }).every(function() {
    var sum = this
      .data()
      .reduce(function(a, b) {
        var x = parseFloat(a) || 0;
        var y = parseFloat(b) || 0;
        return x + y;
      }, 0);
    $(this.footer()).html(currency+' '+sum.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2}));
  });
}


    });



$("#btn-filter").on('click', function ( e ) {
mydatatable.ajax.reload();  
});

});
