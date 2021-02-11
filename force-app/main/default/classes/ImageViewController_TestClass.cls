// Copyright (c) 2014, Doug Merrett, Sales Engineering, Salesforce.com Inc.
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are permitted
// provided that the following conditions are met:
// Redistributions of source code must retain the above copyright notice, this list of conditions
// and the following disclaimer. 
// Redistributions in binary form must reproduce the above copyright notice, this list of conditions
// and the following disclaimer in the documentation and/or other materials provided with the distribution.
// Neither the name of the salesforce.com nor the names of its contributors may be used to endorse or
// promote products derived from this software without specific prior written permission. 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
// WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
// PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
// ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
// TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

//
// History
//
// Version  Date            Author          Comments
// 1.0      16-Mar-2009     Doug Merrett    Initial version
// 2.0      28-Feb-2012     Doug Merrett    Changed the test class to have more attachments and test every line
// 3.0      07-Jan-2014     Doug Merrett    Add assertions to the test to make it a clean security check
//

@isTest
private class ImageViewController_TestClass
{
    static testMethod void test_ImageViewController ()
    {
        // Create a contact to hang an image from
        Contact Cont = new Contact (FirstName = 'Doug', LastName = 'Merrett');        
        insert Cont;
        
        // Create an image attachment
        List <Attachment> attachments = new List <Attachment> ();
        
        // This attachment will display
        Attachment attach  = new Attachment ();   // Create an attachment that has correct content type and extension
        attach.parentId    = Cont.id;             // hook it to our contact
        attach.body        = EncodingUtil.base64decode ('R0lGODlhAwADAIAAAAAAAP///ywAAAAAAwADAAACA4x/BQA7');  // Base64 of a small GIF file
        attach.contenttype = 'image/gif';        
        attach.name        = 'dot.gif'; 
        attachments.add (attach);                 // add it to the list of attachments        

        // This attachment will display
        attach  = new Attachment ();              // Create an attachment with an incorrect content type and a valid extension
        attach.parentId    = Cont.id;             // hook it to our contact
        attach.body        = EncodingUtil.base64decode ('R0lGODlhAwADAIAAAAAAAP///ywAAAAAAwADAAACA4x/BQA7');  // Base64 of a small GIF file
        attach.contenttype = 'application/octet-stream';        
        attach.name        = 'dot.gif'; 
        attachments.add (attach);                 // add it to the list of attachments
        
        // This attachment will display
        attach  = new Attachment ();              // Create an attachment with a correct content type and no extension
        attach.parentId    = Cont.id;             // hook it to our contact
        attach.body        = EncodingUtil.base64decode ('R0lGODlhAwADAIAAAAAAAP///ywAAAAAAwADAAACA4x/BQA7');  // Base64 of a small GIF file
        attach.contenttype = 'image/gif';        
        attach.name        = 'dot'; 
        attachments.add (attach);                 // add it to the list of attachments
        
        // This attachment will not display
        attach             = new Attachment ();   // Create an attachment that is not an image at all
        attach.parentId    = Cont.id;             // hook it to our contact
        attach.body        = Blob.valueOf ('12'); // and add some text
        attach.contenttype = 'text/ascii';
        attach.name        = 'test.txt';
        attachments.add (attach);                 // add it to the list of attachments
        
        // This attachment will not display
        attach             = new Attachment ();   // Create an attachment with no extension and not an image content type
        attach.parentId    = Cont.id;             // hook it to our contact
        attach.body        = Blob.valueOf ('12'); // and add some text
        attach.contenttype = 'text/ascii';
        attach.name        = 'noextension';       // this time, there is no extension, so it won't be shown either
        attachments.add (attach);

        insert attachments;                       // Save them to the database
        
        // Set the reference to the VF pafe
        PageReference pageRef = Page.ShowImageAttachments;
        Test.setCurrentPageReference (pageRef);
        
        // Set the parameter to reference our contact
        ApexPages.currentPage ().getParameters ().put ('id', Cont.id);    
        
        // Instantiate a standard controller class with our contact
        ApexPages.StandardController stdCon = new ApexPages.StandardController (Cont);
        
        // Instantiate the custom controller which will then test the whole process
        ImageViewController ivc = new ImageViewController (stdCon);
        
        // Now check to see if we get 3 images in our list
        system.assertEquals(ivc.Photos.size (), 3);
    }    
}