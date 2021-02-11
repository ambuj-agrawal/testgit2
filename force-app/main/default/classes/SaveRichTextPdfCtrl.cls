public class SaveRichTextPdfCtrl {
    public string htmlvalue{get;set;}
    
    public SaveRichTextPdfCtrl(){
        htmlvalue = ApexPages.currentPage().getParameters().get('htmlvalue');
    }
}