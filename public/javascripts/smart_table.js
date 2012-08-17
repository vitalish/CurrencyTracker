var SmartTable = {
  initialize: function(root, chart) {
    var self = this;
    self.root= root;
    self.form = $('form', self.root);
    self.url = self.form.attr('action');
    self.chart_cotainer = $(chart)[0];
    self.progress_url = $(self.chart_cotainer).data('progress_url');
    self.series_name = $(self.chart_cotainer).data('series_name');
    self.point_name = $(self.chart_cotainer).data('point_name');

    self.form.submit(function() {
      self.form_submit_handler();
      return false;
    });

    $('.filter', self.root).keyup(function(){
      self.filter($(this).val())
    });

    $('.select_all', self.root).click(function(){
      self.select_visible();
    });
    self.init_line_chart();
  },

  form_submit_handler: function() {
    var self = this;
    if (self.has_checked_rows()) {
      $.post(self.url + '.json', self.form.serialize(), function(data) {
        self.add_progress_to_line_chart(data);
        self.success();
      });
    }
  },

  checked_rows: function() {
    return $('.select_row:checked', this.root);
  },

  visible_rows: function() {
    return $('.select_row:visible:enabled', this.root);
  },

  has_checked_rows: function() {
    return (this.checked_rows().size() > 0);
  },

  change_status: function(row) {
    $('.status', row).html(this.point_name)
  },

  success: function() {
    var self = this,
        checked_rows_count = self.checked_rows().size();
    self.checked_rows().each(function(index) {
      self.change_status($(this).closest('tr'));
      $(this).attr('checked', false);
      $(this).attr('disabled', true);
    });
    self.update_simple_pie(checked_rows_count);
  },

  update_simple_pie: function(value) {
    // http://chart.googleapis.com/chart?cht=p3&chs=300x100&chco=0000FF&chd=t:27,217&chdl=Visited|Not%20Visited
    var selected, left, matchdata, newsrc, newselected, newleft, string_to_replace, new_value,
        chart = $('.simple_pie_chart img'),
        src = chart.attr('src');
        regexp = /^.*&chd=t:(\d*),(\d*)&.*$/;
        if (regexp.test(src)) {
          matchdata = src.match(regexp);
          selected = matchdata[1];
          left = matchdata[2];
          newselected = parseInt(selected) + value;
          newleft = parseInt(left) - value;
          string_to_replace = '&chd=t:' + selected + ',' + left + '&';
          new_value = '&chd=t:' + newselected + ',' + newleft + '&';
          newsrc = src.replace(string_to_replace, new_value);
          chart.attr('src', newsrc);
        }
  },

  init_line_chart: function() {
    var self = this;
    self.chart_data = [];
    self.draw_line_chart();
    $.getJSON(self.progress_url, function(data) {
      self.add_progress_to_line_chart(data);
    });
  },

  add_progress_to_line_chart: function(progress) {
    var self = this,
        series = self.chart.series[0],
        data_count = self.chart_data.length;

    $.each(progress, function(index, el) {
      self.chart_data.push([el.date, data_count + index + 1 ]);
    });
    series.setData(self.chart_data);
  },

  draw_line_chart: function() {
    var self = this;
    self.chart = new Highcharts.Chart({
      chart: {
        renderTo: self.chart_cotainer,
        type: 'spline'
      },
      title: {
        text: 'Progress'
      },
      xAxis: {
        type: 'datetime'
      },
      yAxis: {
        title: {
          text: 'Count'
        },
        allowDecimals: false,
        min: 0
      },
      series: [{
        name: self.series_name,
        data: []
      }],
      tooltip: {
        formatter: function() {
          return '<b>'+ this.series.name +'</b><br/>'+
            Highcharts.dateFormat('%e %b', this.x) +': '+ this.y + ' ' + self.point_name;
        }
      }
    });
  },

  hide_all: function() {
    $('tr',this.root).hide();
  },

  select_visible: function() {
    this.un_select_all();
    this.visible_rows().attr('checked', true);
  },

  un_select_all: function() {
    this.checked_rows().attr('checked', false);
  },

  filter: function(query) {
    var lcquery = query.toLowerCase();
    $('tr',this.root).each(function(index) {
      var name_tag = $('td.name', $(this));
      if (name_tag.size() > 0) {
        var name = name_tag.html().toLowerCase();
        if(name.search(lcquery)!= -1) {
          $(this).show();
        } else {
          $(this).hide();
        }
      }
    });
  }

};

$(document).ready(function() {
  $('.smart_table').each(function() {
    SmartTable.initialize(this, '#line_chart');
  });
})