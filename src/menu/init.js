var app = Elm.Main.init({});

app.ports.activeTabExecuteScript.subscribe(function (data) {
  browser.tabs.executeScript({
    code: data.code
  }).then(
    res => {
      r = {ok: res, id: data.id};
      console.log("result", res);
      app.ports.activeTabScriptResult.send(r)
    },
    err => app.ports.activeTabScriptResult.send({error: res.toString(), id: data.id})
  )
})
