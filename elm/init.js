var app = Elm.Main.init({});

app.ports.activeTabExecuteScript.subscribe(function (data) {
  browser.tabs.executeScript({
    code: data.code
  }).then(
    res => {
      app.ports.activeTabScriptResult.send({ok: res[0], id: data.id});
    },
    err => app.ports.activeTabScriptResult.send({error: err.toString(), id: data.id})
  )
})
