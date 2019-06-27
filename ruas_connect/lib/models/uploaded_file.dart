class UploadedFile {
  final String title;
  final String description;
  final DateTime dateUploaded;
  final String uploaderUsername;
  final String filename;
  final String size;
  final String downloadUrl;
  final String uploaderUid;

  UploadedFile(
      this.title,
      this.description,
      this.dateUploaded,
      this.uploaderUsername,
      this.filename,
      this.size,
      this.downloadUrl,
      this.uploaderUid);
}
