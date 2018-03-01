// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

/*
Attribution Nats Lecture notes
*/

var start_time = "";
var time_id = "";

function set_button(task_id, type) {
  $('.time-button').each( (_, bb) => {
    if (type === "start") {
      if (task_id == $(bb).data('task-id')
      && $(bb).data('type') === "start") {
        $(bb).data('clicked', "Yes");
      }
    }
    else {
      if (task_id == $(bb).data('task-id')
      && $(bb).data('type') === "start") {
        $(bb).data('clicked', "No");
      }
    }
  });
  update_buttons();
}

function update_buttons() {
  $('.time-button').each( (_, bb) => {
    let task_id = $(bb).data('task-id');
    let type = $(bb).data('type');
    let clicked = $(bb).data('clicked');
    if (type === "start" && clicked === "Yes") {
      $(bb).text('Started');
      $(bb).click(function() { return false; });
    }
    else if (type === "start" && clicked === "No") {
      $(bb).text('Start Task');
    }
    else if (type === "end") {
      $(bb).text('End Task');
    }
    else {
      alert("time");
    }
  });
}

function start(task_id, time, btn) {
  let text = JSON.stringify({
    timeblock: {
      start: time,
      end: null,
      time_id: time_id,
      task_id: task_id,
    },
  });
  alert("Task started");
  console.log(text);

  $.ajax(timeblock_path, {
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => {
      time_id = resp.data.id;
      set_button(task_id, "Start"); },
      error: (resp) => { console.log(resp); }
    });
  }

  function end(task_id, time) {
    let text = JSON.stringify({
      timeblock: {
        start: start_time,
        end: time,
      },
    });
    alert("Task ended");

    $.ajax(timeblock_path + "/" + time_id, {
      method: "PUT",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
      success: (resp) => { set_time_link(task_id, "End"); },
      error: (resp) => { console.log(resp); }
    });
  }

  function delete_click(ev){
    let btn = $(ev.target);
    let time_id = btn.data('time-id');
    console.log(time_id);
    $.ajax(timeblock_path + "/" + time_id, {
      method: "DELETE",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "{}",
      success: (resp) => {},
      error: (resp) => { console.log(resp); }
    });
  }

  function update_start_click(ev){
    let btn = $(ev.target);
    let time_id = btn.data('time-id');

    var d = new Date($('#start_edit'+time_id).val());
    var new_time = d.toUTCString();

    let text = JSON.stringify({
      timeblock: {
        start: new_time,
      }
    });

    $.ajax(timeblock_path + "/" + time_id, {
      method: "PUT",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
      success: (resp) => {},
      error: (resp) => { console.log(resp); }
    });
  }

  function update_end_click(ev){
    let btn = $(ev.target);
    let time_id = btn.data('time-id');

    var d = new Date($('#end_edit'+time_id).val());
    var new_time = d.toUTCString();

    let text = JSON.stringify({
      timeblock: {
        end: new_time,
      }
    });

    $.ajax(timeblock_path + "/" + time_id, {
      method: "PUT",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
      success: (resp) => {},
      error: (resp) => { console.log(resp); }
    });
  }

  function time_click(ev) {
    let btn = $(ev.target);
    let type = btn.data('type');
    let task_id = btn.data('task-id');
    console.log(task_id);
    let time = btn.data('time');
    if (type === "start") {
      start_time = time;
      start(task_id, time, btn);
    }
    else if (type == "end") {
      end(task_id, time);
    }
    else {
      alert("time");
    }
  }


  function init() {
    if (!$('.time-button')) {
      return;
    }
    $(".time-button").click(time_click);
    update_buttons();
    if (!$('.delete-button')) {
      return;
    }
    $(".delete-button").click(delete_click);
    update_buttons();

    if (!$('.update-start-button')) {
      return;
    }
    $(".update-start-button").click(update_start_click);
    update_buttons();

    if (!$('.update-end-button')) {
      return;
    }
    $(".update-end-button").click(update_end_click);
    update_buttons();
  }

  $(init);
