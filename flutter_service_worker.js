'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "13e18fd4ff372b9dbb55bda11fde075a",
"version.json": "7bf601278f8afcaee1934a1b29f9748b",
"index.html": "53fc12961a4c9db60558ac965dd90c39",
"/": "53fc12961a4c9db60558ac965dd90c39",
"main.dart.js": "447ad171871c40aea745639644cfe64b",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "1e6c22c21824cd05d1e48605d4e9db13",
"assets/AssetManifest.json": "ca762ffd42475a2c430a1bcd17e78018",
"assets/NOTICES": "bd531b9fde805dc9b7aaa0032275804a",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "7042c5109a9d9b101f2dae1515054068",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "7a9856689d13935ceed6520248a6feda",
"assets/fonts/MaterialIcons-Regular.otf": "778a1f44fe034fbce7a917be14bf4832",
"assets/assets/l10n/app_de.json": "673c050ee1765387a813eda762488006",
"assets/assets/l10n/app_ru.json": "813f186379123bed028b45dea8cb5d3a",
"assets/assets/l10n/app_pl.json": "c7026ffbbc7aba5732e482b98142e5f2",
"assets/assets/l10n/app_ta.json": "0b563607568421e6b6d325719ea86a10",
"assets/assets/l10n/app_ur.json": "254c8f3408363603e5453a6ff9ab15a3",
"assets/assets/l10n/app_ml.json": "3842b532c1d9e70f708039743d8c8e0b",
"assets/assets/l10n/app_pt.json": "7201ae92d08e5b48ea96b56cd2c05d3f",
"assets/assets/l10n/app_pa_pk.json": "2404e8d6ea402fccc1d276b7d1f05612",
"assets/assets/l10n/app_pa.json": "3e30ee0d75806eeace2a1b34b9249924",
"assets/assets/l10n/app_en.json": "55cd626ed790ff05e79937a3ab10f6fb",
"assets/assets/l10n/app_my.json": "149d05f2f0e1b47a8a8864f796c06311",
"assets/assets/l10n/app_it.json": "ce5f83ec13b480c5bae2fbdc436a3628",
"assets/assets/l10n/app_hr.json": "687aefb00ab35c687c7a496750cb528d",
"assets/assets/l10n/app_hy.json": "ab2557f9bd4b33c1e41ead483f3e7182",
"assets/assets/l10n/app_zh_cn.json": "07d71eebfe22c3cbc7e80852c1284be6",
"assets/assets/l10n/app_or.json": "8cda05acdd5d5d12e75957deb72315b8",
"assets/assets/l10n/app_sl.json": "d3d2d66348f348398034074c996fe78f",
"assets/assets/l10n/app_tr.json": "cd61943392fa89b64b062ddaafd70635",
"assets/assets/l10n/app_mr.json": "02afc0bb68dc1d8a1acb1281d22c1216",
"assets/assets/l10n/app_bn.json": "4250234e3781948d8d8524ddb555f4aa",
"assets/assets/l10n/app_ha.json": "88df70f8f66c9aac060d09db4bc1d5c0",
"assets/assets/l10n/app_yo.json": "8ef00815787c7c6b26d557c06669a02a",
"assets/assets/l10n/app_zh_hk.json": "a7b906c4b22084c631550c2b958739d2",
"assets/assets/l10n/app_ja.json": "e08e636ff55ebf39e40f97a398754ea9",
"assets/assets/l10n/app_vi.json": "44bcdd5ada9cff3fa91c7fd11dbb7a99",
"assets/assets/l10n/app_fa.json": "000eab69fefd46cf9e19a1097399e526",
"assets/assets/l10n/app_lo.json": "e28934413edfcf21e5d0c66f7cc51e72",
"assets/assets/l10n/app_te.json": "d75f213a501b4f7d09a59ea14ff4d29b",
"assets/assets/l10n/app_id.json": "e355ad8ba00705a6c965988a5b0d429c",
"assets/assets/l10n/app_sw.json": "5de2eeded3e2994b8372528d3cc62466",
"assets/assets/l10n/app_zh_tw.json": "861bd13d33f07a7abab86582cd816d65",
"assets/assets/l10n/app_th.json": "02bd8667c157928090c2b2eb4b89d0df",
"assets/assets/l10n/app_es.json": "4085626ae8134b1b8afbd5842042c1c9",
"assets/assets/l10n/app_ar.json": "bb8f20186c23898f18eab94561f71be3",
"assets/assets/l10n/app_so.json": "ac84be2372d781579a670103dc910970",
"assets/assets/l10n/app_bho.json": "cb944d58168fc89045a1979a524dab20",
"assets/assets/l10n/app_kn.json": "55fc2639d6272bbf3a1bcdaf967ba8a9",
"assets/assets/l10n/app_mai.json": "9c90e28ce98de9f7ef84055ffd8269b8",
"assets/assets/l10n/app_ne.json": "9c7b6b35b3c27079127f185cf9866ba9",
"assets/assets/l10n/app_bs.json": "1d304730342148edf37203cee972d7a1",
"assets/assets/l10n/app_fr.json": "eb41436678ee109c5ece6ddc6d4c50f3",
"assets/assets/l10n/app_am.json": "d65803f60c93f73b9c98d8bd6bfc22e6",
"assets/assets/l10n/app_gu.json": "3756a421d3d6b796bc614b5aaf77d063",
"assets/assets/l10n/app_ro.json": "a1e8ea861e7f5014a17a001bc712ea1a",
"assets/assets/l10n/app_hi.json": "8d4a25ab4a0539e194f581c92b2a5963",
"assets/assets/l10n/app_ko.json": "6f57e304595d304611aef6bc58b372d4",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
