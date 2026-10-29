local PREFIX = "ctrl+a"

rex.bind(PREFIX .. ">" .. PREFIX, "pane.send_key", { key = PREFIX })

rex.bind(PREFIX .. ">-", "pane.split", { direction = "down" })
rex.bind(PREFIX .. ">\\", "pane.split", { direction = "right" })

rex.bind(PREFIX .. ">down", "pane.move.down")
rex.bind(PREFIX .. ">up", "pane.move.up")
rex.bind(PREFIX .. ">left", "pane.move.left")
rex.bind(PREFIX .. ">right", "pane.move.right")

rex.bind(PREFIX .. ">n", "client.tab.next")
rex.bind(PREFIX .. ">p", "client.tab.previous")
rex.bind(PREFIX .. ">c", "client.tab.new")

rex.unbind("alt+cmd+left", "pane.focus.left")
rex.unbind("alt+cmd+right", "pane.focus.right")
rex.unbind("alt+cmd+up", "pane.focus.up")
rex.unbind("alt+cmd+down", "pane.focus.down")

rex.bind("cmd+h", "pane.focus.left")
rex.bind("cmd+l", "pane.focus.right")
rex.bind("cmd+k", "pane.focus.up")
rex.bind("cmd+j", "pane.focus.down")
