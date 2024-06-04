const protocol = 'http';
const host = 'download.home';
const port = 80;
const serverUrl = `${protocol}://${host}:${port}/downloads`;

function onCreated() {
  if (browser.runtime.lastError) {
    console.log(`Error: ${browser.runtime.lastError}`);
  } else {
    console.log("Item created successfully");
  }
}

browser.contextMenus.create(
  {
    id: "downloader",
    title: "Send to Downloader",
    contexts: ["all"],
  },
  onCreated
);

browser.contextMenus.onClicked.addListener((info, tab) => {
  if (info.menuItemId === 'downloader' ) {
    const linkUrl = info.linkUrl;
    
    let body = {};
    body['url'] = linkUrl;

    console.log(body)

    fetch(
      serverUrl,
      {
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        method: 'POST',
        body: JSON.stringify(body)
      }
    ).then((result) => {
      console.log(result)
    })
}
});