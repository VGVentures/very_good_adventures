'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "icons/Icon-192.png": "8afa706053b186edf013b6c9880872f9",
"icons/favicon.png": "fa7fde306a35e196516bf8b1d6100f14",
"icons/Icon-512.png": "70dd4c7d62910514def11f21e23d99f8",
"index.html": "06c9cca8f6bd0d219f58673b040b9e13",
"/": "06c9cca8f6bd0d219f58673b040b9e13",
"main.dart.js": "790657239337636854b8a09c63c9ec00",
"version.json": "7c615b47c8bca034d95387c7dd47c02d",
"favicon.png": "fa7fde306a35e196516bf8b1d6100f14",
"flutter.js": "0816e65a103ba8ba51b174eeeeb2cb67",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.json": "63b58353961d7a98c47799f2fa313dd9",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/images/player_4.png": "438960a9cbf9970ac1bbc0acc1c249f5",
"assets/assets/images/logo.png": "6812c030d2b10fee69d12c2559f74e9a",
"assets/assets/images/unicornHoddie_gear.png": "daa89fa3aea5497b528d7a4570758edd",
"assets/assets/images/shield_gear.png": "3b77c3b0b08745757962b9245c17fdcc",
"assets/assets/images/unicornHoddie.png": "eed15eee6f56fe846fe798d5eadc0d41",
"assets/assets/images/background.png": "0373d3bd2cf58b9c64dbff3efe037eba",
"assets/assets/images/player_silhouette.png": "de6c42d69442ce36df21d46b5ae10ab1",
"assets/assets/images/player_3.png": "4c7a7e5cee0206756b9548225a26c5d1",
"assets/assets/images/sword.png": "0c87a0cd9f8663eaccc9a8bc30b5b74f",
"assets/assets/images/player_2.png": "8bf85ad8162a76d1a9a6c892ab9a34c6",
"assets/assets/images/chest_closed.png": "d931273258d7bba38ce7f6ee3983d17a",
"assets/assets/images/chest_open.png": "87c13012e8ffb11ce6d7e0118b7733b3",
"assets/assets/images/shield.png": "f6aca22ca8d497d6cece41323df9e098",
"assets/assets/images/birdHoddie_gear.png": "912b5356b11aad4f9286cfe4ee0faf4b",
"assets/assets/images/birdHoddie.png": "bb93e207e5fbb98b77daf332e38abb94",
"assets/assets/images/sword_gear.png": "8d09f097c8991cc28f1c912c0b61af91",
"assets/assets/images/player.png": "ae729f64fc58f95d51e7e927db8ab36e",
"assets/assets/images/title.png": "d7c347a2fc0a657fed169dbeeb5005cd",
"assets/NOTICES": "81c20d03328fdc4e8fbc9e53f13c2736",
"manifest.json": "80fa173dfe9b872ca85ca079f7adbf5c"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
