@extends('layouts.layout')
@section('content')
<title>Data Ruangan</title>

<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-dark">Data Ruangan</h6>
</div>
<div class="card-body">
  <div class="table-responsive">
    <button class="btn btn-success" data-toggle="modal" data-target="#tambah">Tambah Data</button>
      <br>
      <br>
      <table id="dataTable" class="table table-bordered" cellspacing="0">
          <thead>
            <tr>
                  <th>No</th>
                  <th>Nama Gedung</th>
                  <th>Nama Ruangan</th>
                  <th>Opsi</th>
            </tr>
          </thead>
          <tbody>
            @foreach ($ruangan as $i => $u)
            <tr class="data-row">
              <td class="align-middle iteration">{{ ++$i }}</td>
              <td class="align-middle id_barang">{{ $u->gedung->gedung }}</td>
              <td class="align-middle id_barang">{{ $u->ruangan }}</td>
              <td>  
                <div class="row">
                   <a href="/ruangan/edit/{{ $u->id_ruangan}}" class="btn btn-primary btn-sm ml-2">Edit</a>
                   <a href="/ruangan/hapus/{{ $u->id_ruangan }}" class="btn btn-danger btn-sm ml-2">Hapus</a>
                </div>
              </td>
            </tr>
            @endforeach
          </tbody>
        </table>
  </div>
</div>

  <div id="tambah" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Masukan Data</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
        <form action="/ruangan/store" method="post">
            {{ csrf_field() }}
          <div class="form-group">
              <label for="">Gedung</label>
              <select name="id_gedung"  class="myselect" id="" style="width:100%">
                <option value="" selected disabled>Pilih Gedung</option>
                @foreach ($gedung as $a)
                    <option value="{{$a->id_gedung}}">{{$a->gedung}}</option>
                @endforeach 
              </select>
          </div>
          <div class="form-group">
              <label for="">Ruangan</label>
              <input type="text" name="ruangan" class="form-control"  required>
          </div>
          
          {{-- <div class="form-group"
              <label for="">Pj</label>
              <select name="id_pj" class="myselect" id="" style="width:100%">
                <option value="" selected disabled>Pilih Pj</option>
                @foreach ($pj as $b)
                    <option value="{{$b->id}}">{{$b->name}}</option>
                @endforeach
              </select>
          </div> --}}
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <button type="submit" class="btn btn-primary">Simpan</button>
        </form>
        </div>
      </div>
    </div>
  </div>
@endsection