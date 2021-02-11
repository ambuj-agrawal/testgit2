public class ZipHandler1 {
	public Integer randomInt{get;set;}
    //Constructor
    public ZipHandler1(){
        randomInt = getRandomNumber(10000);
    }
    
    @RemoteAction
    public static List<AttachmentWrapper> getAttachments(String sAttachmentIdCSV){
        List<String> attachmentIds = sAttachmentIdCSV.split(',');
        return wrapAttachments([SELECT id, ContentDocumentId,VersionData,title,FileType FROM ContentVersion WHERE Id IN:attachmentIds]);
    }    
    
    private static List<AttachmentWrapper> wrapAttachments(List<ContentVersion> attachments){
        List<AttachmentWrapper> wrappers = new List<AttachmentWrapper>();
        for(ContentVersion att : attachments){
            wrappers.add(new AttachmentWrapper(att));
        }        
        return wrappers;
    }
    
    public class AttachmentWrapper{
        public Attachment AttachmentObj;
        public String base64Body;        
        public AttachmentWrapper(ContentVersion AttachmentObj){
            Attachment att = new Attachment();
            this.AttachmentObj = att;
            this.AttachmentObj.Name  = AttachmentObj.title+'.'+AttachmentObj.FileType;
            this.base64Body = EncodingUtil.base64Encode(AttachmentObj.VersionData);
            this.AttachmentObj.Body = NULL;
        }
    }
    
    /*
    *Random number generator to change the js function name if multiple components used
    */
    private Integer getRandomNumber(Integer size){
        Double d = Math.random() * size;
        return d.intValue();
    }
}