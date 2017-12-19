'use strict';
var Dropbox = require('dropbox');

module.exports =
  class {

    constructor(token) {
      this.dbx = new Dropbox({
        accessToken: token
      });
    }

    print() {
      //console.log('Name is : dbx');
      let self = this;
      this.dbx.filesListFolder({
          path: '/backup'
        })
        .then(function(response) {
          console.log(response);
          self.displayFiles(response.entries);
        })
        .catch(function(error) {
          console.log(error);
        });
    }

    displayFiles(files) {
      for (var i = 0; i < files.length; i++) {
        console.log(files[i].name);
      }
    }
  };
