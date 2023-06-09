@extends('layouts.layout')
@section('content')
<title>Data Barang</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>  
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-dark">QRCode</h6>
</div>
<div class="card-body text-center">
  <div id="example">
   <h3>QR Code <br> {{$qrcode->nama_barang}}</h3>
  {!! QrCode::size(100)->generate($qrcode->nup); !!}
                        </div> 
                        <br>
                        
<input type="button" value="Print" class="btn btn-primary" onclick="printDiv(example);"/>
</div>

<script>
function printDiv(example) {
      var printContents = document.getElementById("example").innerHTML;    
   var originalContents = document.body.innerHTML;      
   document.body.innerHTML = printContents;     
   window.print();     
   document.body.innerHTML = originalContents;
   }
</script>

@endsection