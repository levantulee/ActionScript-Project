private function writeFile():void {
	var contents:String = "CONTENTS of XML File";
	var fileStream:FileStream = new FileStream();
	var file:File = File.desktopDirectory;
	file = file.resolvePath("SomeDirOnDeskTop/newXML.xml");
	fileStream.open(file, FileMode.WRITE);
	fileStream.writeUTFBytes(contents);
	fileStream.close();
}