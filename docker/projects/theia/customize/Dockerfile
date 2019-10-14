FROM theiaide/theia-full:next

RUN sed -i '/dependencies/a \\t"@devpodio/theia-vue-extension": "0.2.1",' /home/theia/package.json
RUN yarn
RUN yarn theia build
