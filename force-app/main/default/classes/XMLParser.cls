public class XMLParser{

    
    public XMLparser(String res){
       
        DOM.Document doc=new DOM.Document();
        try{
            doc.load(res);
            DOM.XmlNode rootNode=doc.getRootElement();
            parseXML(rootNode);
            
        }catch(exception e){
            system.debug(e.getMessage());
        }
    }
    
    private void parseXML(DOM.XMLNode node) {
        if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
                    
            if(node.getName()=='key'){
                string Key=node.getText().trim();
            	system.debug('***key '+Key);
            }
            if(node.getName()=='No'){
                string No=node.getText().trim();
            	system.debug('***No '+No);
            }
            
        }
        for (Dom.XMLNode child: node.getChildElements()) {
            parseXML(child);
        }
    }
}