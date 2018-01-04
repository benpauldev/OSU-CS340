
var get_url = function(e) {
  return '/' + $(e.target).attr('data-type');
};

var make_table = function(json, tableName) {
  var table = "<table class='table-bordered'>";
  var parsed = json.results;
  var keys = make_keys(parsed[0]);
  table += column_titles(keys);
  $.each(parsed, function(i, val) {
    var row = '';
    var id;
    for (var key in val) {
      if (key !== 'id') {
        row += '<td>' + val[key] + '</td>';
      } else {
        id = val[key];
        row += "<tr data-id='" + val[key] + "'>";
      }
    }
    row += "<td><button data-type='" + tableName + "' data-id='" + id + "' class='btn btn-danger delete'>Delete</button></td>";
    row += '</tr>';
    table += row;
  });
  table += "</table>";
  return table;  
};

var column_titles = function(keys) {
  var header = '<tr>';
  for (var i = 0; i < keys.length; i++) {
    if (keys[i] !== 'id') {
      header += '<th>' + keys[i] + '</th>';
    }
  }
  header += '<th>Delete</th>';
  header += '</tr>';
  return header;
};

var print_table = function(url, selector) {
  $.ajax({
    url: url,
    dataType: 'json',
    success: function(data) {
      $(selector).html('');
      $(selector).append('<h3>' + selector.substring(1) + '</h3>' + make_table(data, selector.substring(1)));
      $(selector).append(make_form(selector, make_keys(data.results[0])));
      $(selector + ' .save').on('click', submit_form);
      $(selector + ' .delete').on('click', delete_form);
    }
  });
};

var make_form = function(selector, keys) {
  var type = selector.substring(1);
  var form = "<form class='form-horizontal'>";
  for (var i = 0; i < keys.length; i++) {
    if (keys[i] === 'id') continue;
    form += "<div class='form-group'><label class='col-sm-2 control-label'>" + keys[i] + "</label>";
    form += "<div class='col-sm-6'>";
    form += "<input type='text' class='form-control' id='" + keys[i] + "'>";
    form += "</div></div>";
  }
  form += "<div class='form-group'><div class='col-sm-10 col-sm-offset-7'>";
  form += "<button class='btn btn-submit save' data-type='" + type + "' type='submit'>Save</button>";
  form += "</div></div>";
  form += "</form>";

  return form;
};

var make_keys = function(data) {
  var keys = [];
  for (var key in data) {
    keys.push(key);
  }
  return keys;
};



var make_post = function(e) {
  var data = {};
  var selector = '#' + $(e.target).attr('data-type') + ' .form-group';
  var entries = $(selector).each(function(i, el) {
    var label = $('label', el).text();
    if (label.length > 0) {
      var inputVal = $('input', el).val().length > 0 ? $('input', el).val() : null;
      data[label] = inputVal;
    }
  });

  return data;
};

var delete_form = function(e) {
  e.preventDefault();
  var req = {};
  var id = $(e.target).attr('data-id');
  if (id !== 'undefined') {
    req = { 'id': id };
  } else {
    var selector = $(e.target).attr('data-type');
    var keysArr = $('#' + selector + ' th').map(function(){
      return $(this).text();              
    }).get();
    var valuesArr = $(e.target).closest('tr').children().map(function(){
      return $(this).text();
    });
    req[keysArr[0]] = valuesArr[0];
    req[keysArr[1]] = valuesArr[1];
  }
  var url = '/' + $(e.target).attr('data-type');

  $.ajax({
    url: url,
    dataType: 'json',
    data: req,
    type: 'DELETE',
    success: function(data) {
      render();
    }
  }); 
}


var submit_form = function(e) {
  e.preventDefault();
  var data = make_post(e);
  var url = get_url(e);
  $.ajax({
    url: url,
    dataType: 'json',
    type: 'POST',
    data: data,
    success: function() {
      render();
    }
  });  
};



var make_selector = function(data) {
  var str = '';
  for (var key in data) {
    str += "<option value='" + data[key] + "'>" + data[key] + "</option>"; 
  }
  return str;
};

var search = function(e) {
  e.preventDefault();
  var country_name = $('#name').val();
  var obj = { 'name': country_name };
  console.log(obj);
  $.ajax({
    dataType: 'json',
    type: 'POST',
    url:'/search_artists',
    data: obj,
    success: function(data) {
      var results = data.results;
      $('.search_results').html('');
      for (var i = 0; i < results.length; i++) {
        var str = '<li>' + results[i].fname + ' ' + results[i].lname + '</li>';
        $('.search_results').append(str);
      }
    }
  });
};

var render = function() {
   print_table('/artists', '#artists');
   print_table('/country', '#country');
   print_table('/city', '#city');
   print_table('/medium', '#medium');
   print_table('/artists_medium', '#artists_medium');
   print_table('/artists_residence', '#artists_residence');
   $('.search').on('click', search);
};

$(document).ready(function() {
  render();
});