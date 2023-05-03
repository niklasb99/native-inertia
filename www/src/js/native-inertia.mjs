import axios from 'axios';

const getFakeError = config => {
  const mockError = new Error();
  mockError.response = {
    data: { "component": "Home", "props": { "errors": {}, "appName": "Something" }, "url": "\/", "version": "no-version" },
    status: 200,
    statusText: 'OK'
  };
  mockError.config = config;
  return Promise.reject(mockError);
};

const isFakeError = error => Boolean(error.response);

const getResponseFromEvent = async (mockError) => {
  const { config } = mockError;
  // console.log('axios sending native-inertia event', config)
  window.webkit?.messageHandlers['native-inertia']?.postMessage(JSON.stringify(config));

  // Wait for event that contains the real response
  const response = await new Promise(resolve => {
    window.addEventListener('native-inertia', event => {
      // console.log('axios got native-inertia event', event)
      resolve(event.detail);
    });
  });

  const output = {
    config: config,
    headers: {
      'content-type': 'application/json',
      'vary': 'X-Inertia',
      'x-inertia': 'true'
    },
    isFake: true,
    status: 200,
    statusText: 'OK',
    data: {
      ...response,
      version: 'current'
    }
  };

  return Promise.resolve(output);
};

// // Add a request interceptor
axios.interceptors.request.use(config => {
  // console.log('axios mocking ' + config.url);
  return getFakeError(config);
}, error => Promise.reject(error));

// Add a response interceptor
axios.interceptors.response.use(response => response, error => {
  if (isFakeError(error)) {
    // console.log('axios mocking response');
    return getResponseFromEvent(error);
  }
});
