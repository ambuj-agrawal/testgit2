// Copyright (c) 20014, Doug Merrett, Sales Engineering, Salesforce.com Inc.
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
// 2.0      28-Feb-2012     Doug Merrett    Swapped ContentType checking for File Extension checking
// 2.1      14-Mar-2012     Doug Merrett    Added "with sharing" for security reasons (doesn't affect the actual
//                                          functionality...
// 3.0      12-Jul-2013     Doug Merrett    Added ContentType back in as an OR with the file extension
//
// Please see the Instructions document in the ViewAttachments folder in the Documents tab.  This code does not
// need modifying for different parent objects as I use the generic SObject type for the getRecord
// from the standard controller.
//
                
public with sharing class ImageViewController
{
    // Add to the following list if you have other images you want to show
    Set <String> ImageExtensions = new Set <String> {'jpg', 'jpeg', 'gif', 'png'};

    // The record that has the attachments we want to show
    private final SObject so;

    // The photos for the VF page to use
    public List <Photo> Photos {get; private set;}

    // Contains the information for the VF page to render the photo
    public class Photo
    {
        public String id   {get; private set;}
        public String url  {get; private set;}
        public String name {get; private set;}
        
        public Photo (String ipId, String ipName)
        {
            id   = ipId;
            url  = '/servlet/servlet.FileDownload?file=' + id;  // This is the standard SFDC manner to "download" attachments.
            name = ipName;
        }
    }
    
    // Constructor
    public ImageViewController (ApexPages.StandardController controller)
    {
        this.so = controller.getRecord ();
        Photos = new List <Photo> ();
        fetchPhotos ();
    }
    
    private void fetchPhotos ()
    {
        String       FileNameExtn;

        Photos.clear ();  // Empty the list between calls to be sure...
        
        for (Attachment a : [Select Id, Name, ContentType From Attachment Where ParentId = :so.Id])
        {
            // Get the part of the filename after the last '.' (the extension)
            // and compare it to the set of known extensions.
            Integer X = a.Name.LastIndexOf ('.');
            if (X < 0)  // Not Found
                FileNameExtn = 'NOT AN IMAGE';
            else
                FileNameExtn = a.Name.substring (X + 1); 
                
            // Use the extension to check if it is or isn't a file to show.
            if (ImageExtensions.contains (FileNameExtn) || a.ContentType.startsWith ('image/'))    // Does it have a known image extension?
            {
                Photos.add (new Photo (a.Id, a.Name));
            }
        }
    }  
}