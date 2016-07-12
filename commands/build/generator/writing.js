const { createTypeAlias } = require('./type-alias');
const { createDecoder, createEncoder } = require('./decoder');
const fs = require('fs');
const path = require('path');

const CWD = process.cwd();

module.exports = function() {
  // let done = this.async();

  // this.spawnCommandSync('mkdir', ['-p', 'src'], { cwd: CWD });


  let aliases = createTypeAlias(this.data, 'TaskCluster');
  let decoders = aliases.map(alias => createDecoder(alias, true, 'decode'));
  let encoders = aliases.map(alias => createEncoder(alias, true, 'encode'));

  console.log('module TaskCluster exposing (..)\n');
  console.log('import Json.Decode');
  console.log('import Json.Encode');
  console.log(aliases.join('\n'));
  console.log(decoders.join('\n'));
  console.log(encoders.join('\n'));

  // let writeStream = fs.createWriteStream(path.join(
  //   process.cwd(),
  //   'src/TaskCluster.elm'
  // ));
  // let command = this.spawnCommand('python', [
  //   'generate.py',
  //   '../TaskCluster.json'
  // ], { stdio: 'pipe', cwd: path.join(process.cwd(), 'bin') });
  
  

  // command.stdout.pipe(writeStream);
  // command.stderr.pipe(process.stderr);
  // command.on('close', done);




  // let copyDirs = ['src', 'tests'];
  // let copyFiles = [
  //   '.gitignore',
  //   '.travis.yml',
  //   'LICENSE'
  // ];
  // let copyTemplates = [
  //   'package.json',
  //   'README.md',
  //   'src/index.js'
  // ];
  //
  // copyDirs.forEach(dir => {
  //   this.fs.copy(this.templatePath(`${dir}/**/*`), this.destinationPath(dir));
  // });
  //
  // copyFiles.forEach(file => {
  //   this.fs.copy(
  //     this.templatePath(file.startsWith('.') ? file.substr(1) : file),
  //     this.destinationPath(file)
  //   );
  // });
  //
  // copyTemplates.forEach(template => {
  //   this.fs.copyTpl(
  //     this.templatePath(template),
  //     this.destinationPath(template),
  //     { data: this.data }
  //   );
  // });
};
