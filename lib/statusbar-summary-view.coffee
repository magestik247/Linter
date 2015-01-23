{View} = require 'space-pen'

# Status Bar View
class StatusBarSummaryView
  remove: ->
    # TODO: call this when the linter is disabled
    @tile.destroy() if @tile?
    @tile = null

  # Render the view
  render: (messages) ->
    statusBar = document.querySelector("status-bar")
    return unless statusBar?

    info = warning = error = 0

    for item in messages
      info += 1 if item.level == 'info'
      warning += 1 if item.level == 'warning'
      error += 1 if item.level == 'error'

    # Hide the last version of this view
    @remove()

    el = new StatusBarSummary(info, warning, error)
    @tile = statusBar.addRightTile({item: el, priority: 100})

class StatusBarSummary extends View
  @content: (info, warning, error) ->
    @div class: 'linter-summary inline-block', =>
      @div class: 'linter-error inline-block', error, =>
        @span class: 'icon-right'
      @div class: 'linter-warning inline-block', warning, =>
        @span class: 'icon-right'
      @div class: 'linter-info inline-block', info, =>
        @span class: 'icon-right'

module.exports = StatusBarSummaryView
