$(document).ready(function () {
  $(function () {
    window.addEventListener("message", function (event) {
      var e = event.data;
      if (e.action === "open-ui") {
        SetupUI(e.data);
      } else if (e.action === "open-stack") {
        SetupStack(e.data);
      } else if (e.action === "update-stack") {
        UpdateStack(e.event, e.count);
      } else if (e.action === "close-stack") {
        $("#stack-quest").empty()
        $(".leaderboard").hide()
      }
      document.onkeyup = function (data) {
        if (data.which == 27) {
          $(".container").fadeOut(500);
          $.post("https://2Dev-Quest/Exit", JSON.stringify({}));
          return;
        }
      };
    });
  });
});

const QuestAction = (key) => {
  var cls = $(`#btn-key-${key}`).attr('class');
  if (cls === "btn-quest-active") {
    $(`#btn-key-${key}`).text(`Hủy`)
    $(`#btn-key-${key}`).toggleClass("btn-quest-active btn-quest-warning");
    $.post("https://2Dev-Quest/QuestAction", JSON.stringify({ key: key, type: "AcceptQuest" }));
  } else {
    $(`#btn-key-${key}`).text(`Nhận nhiệm vụ`)
    $(`#btn-key-${key}`).toggleClass("btn-quest-warning btn-quest-active");
    $.post("https://2Dev-Quest/QuestAction", JSON.stringify({ key: key, type: "DropQuest" }));
  }
}

const UpdateStack = (e, c) => {
  // $(`#stack-${e}`).text(`Còn ${c}lần`)
  $(`#circle-count-${e}`).text(`${c}`)
}

const SetupStack = (data) => {
  $("#stack-quest").empty()
  $.each(data, function (key, value) {
    $("#stack-quest").append(`
      <li>
        <span class="name">${value.detail}</span>
        <span class="percent" id="stack-${value.key}">Còn <small class="circle-count" id="circle-count-${value.key}">${value.count}</small> lần</span>
      </li>
    `)
  })
  $(".leaderboard").show()
}

const SetupUI = (data) => {
  $(".details").empty();
  var custom;
  let index = 0
  $.each(data, function (key, value) {
    index = index + 1
    if (value.State) {
      custom = `<button id="btn-key-${key}" class="btn-quest-active" onclick="QuestAction('${key}','AcceptQuest')">Nhận nhiệm vụ</button>`
    } else {
      custom = `<button id="btn-key-${key}" class="btn-quest-warning" onclick="QuestAction('${key}','DropQuest')">Hủy</button>`
    }

    $(".details").append(`
    <div class="item">
      <div class="doraemon-header"><a id="job-subjecten">${value.Title}</a></div>
          <div class="doraemon-detail">
            <div class="doraemon-box">
              <div class="doraemon-progress">
                <div class="pic-job">
                  <img
                    src="${value.Picture}"
                    alt=""
                    width="128"
                  />
                </div>
                <div id="progress">
                  <div data-num="100" class="progress-item"></div>
                </div>
              </div>
              <div class="doraemon-process">
                <div class="doraemon-process-custom">
                  <div class="doraemon-process-subject">
                    <p><a id="job-subject">${value.Detail}</a></p>
                  </div>
                  <div class="doraemon-process-count" id="job-couter">
                    x${value.Count}
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="doraemon-footer">
            ${custom}
          </div>
    </div>
  `);
  })
  $(".container").fadeIn(500);
};
