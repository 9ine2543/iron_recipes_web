'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "99edf1b054ad7085849289b36feb8a86",
"/": "99edf1b054ad7085849289b36feb8a86",
"main.dart.js": "86ac67e5e5b0fab0d92f4cda0eb7dd27",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "bb2e4a5e90672b67d340347d6a109949",
"assets/AssetManifest.json": "4f8ab9365b03ebc9a98fd02996756046",
"assets/NOTICES": "d7109e0f1ff747e8e770a6ffa6f0a716",
"assets/FontManifest.json": "993f3f98737d69737cac8ec9d6fd92f9",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b14fcf3ee94e3ace300b192e9e7c8c5d",
"assets/packages/frino_icons/lib/fonts/FrinoIcons.ttf": "374031c28b365ea9539e8160b2931afc",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/assets/Frame%25201.png": "13bdaee600541d5d0ea5ad55ec70e42b",
"assets/assets/Group%252011.png": "2e673191c21cc58a3bea35e1ec8ef271",
"assets/assets/img/201.png": "fba64de2b7ae4b84d253243f441af409",
"assets/assets/img/203.png": "6f238dfe0257590151d9d9d1c3423e87",
"assets/assets/img/202.png": "469a63b3f203403bd4ffec571057979f",
"assets/assets/img/401.png": "a8f63ea4d0ca186ac9e44be91165112f",
"assets/assets/img/403.png": "6e876a31b681c9b8f719e1a227f78d36",
"assets/assets/img/601.png": "97d83cbb0b043fe3b4b7ab1a849e74ab",
"assets/assets/img/402.png": "f6a174f051a8974e3b59e12d7d197a9b",
"assets/assets/img/303.png": "d398699f9225fa016c8a77b61e9a715d",
"assets/assets/img/101.png": "98e8c8505fc2e9754c74a6d3ebe09a93",
"assets/assets/img/302.png": "a70d85709d7384dee4472b19fadc4b98",
"assets/assets/img/102.png": "275f1797a9d52842abe120f770ecaf47",
"assets/assets/img/103.png": "b6d9fd983e82fa4a0f527513e8b03f18",
"assets/assets/img/301.png": "a0e15db326a79ad7d2c21f1af0e5d9c6",
"assets/assets/img/503.png": "dac19907ea3fb64ef6b780f11e0cbf2f",
"assets/assets/img/502.png": "d3a287f9837f5314c384ea6a846e12ae",
"assets/assets/img/104.png": "0a7accd962b3560a7d43e00be9324d12",
"assets/assets/img/501.png": "468edce343bd3407b2cba23e5899fb9e",
"assets/assets/fonts/Kanit/Kanit-ExtraLight.ttf": "e84e29e81d362635427900ac6ae8af07",
"assets/assets/fonts/Kanit/Kanit-SemiBold.ttf": "802435446beb0e3178443e74b0d5a77f",
"assets/assets/fonts/Kanit/Kanit-Regular.ttf": "b935eb6769e902b3b0086459a7c55a05",
"assets/assets/fonts/Kanit/Kanit-Bold.ttf": "d204df3d775c0c90d1773a97743a77b5",
"assets/assets/fonts/Kanit/Kanit-Light.ttf": "3a5af91532287f228070af610add510c",
"assets/assets/fonts/Kanit/Kanit-Medium.ttf": "79d3ce8b773035a13ef1d63f5240e256"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
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
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
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
    return self.skipWaiting();
  }
  if (event.message === 'downloadOffline') {
    downloadOffline();
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
  for (var resourceKey in Object.keys(RESOURCES)) {
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
