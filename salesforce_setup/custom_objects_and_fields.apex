MetadataService.MetadataPort service = new MetadataService.MetadataPort();
service.SessionHeader = new MetadataService.SessionHeader_element();
service.SessionHeader.sessionId = UserInfo.getSessionId();
List<MetadataService.UpsertResult> results;


// Create custom field on the Account object
MetadataService.CustomField customField = new MetadataService.CustomField();
customField.fullName = 'Account.AccountNumber__c';
customField.label = 'External Account Number';
customField.type_x = 'Text';
customField.unique = true;
customField.externalId = true;
customField.caseSensitive = true;
customField.length = 100;

results = service.upsertMetadata(new MetadataService.Metadata[] { customField });

if (!results[0].success){
    throw new ExternalObjectException(results[0].errors[0].message);
}

// make new fields editable by System Administrators
MetadataService.Profile admin = new MetadataService.Profile();
admin.fullName = 'Admin';
admin.custom = false;
MetadataService.ProfileFieldLevelSecurity fieldSec1 = new MetadataService.ProfileFieldLevelSecurity();
fieldSec1.field='Contact.ContactNumber__c';
fieldSec1.editable=true;
fieldSec1.readable=true;
admin.fieldPermissions = new MetadataService.ProfileFieldLevelSecurity[] {fieldSec1} ;
List<MetadataService.SaveResult> profileSaveResults = service.updateMetadata(new MetadataService.Metadata[] { admin });
if (!profileSaveResults[0].success){
    throw new ExternalObjectException(profileSaveResults[0].errors[0].message);
}
MetadataService.ProfileFieldLevelSecurity fieldSec2 = new MetadataService.ProfileFieldLevelSecurity();
fieldSec2.field='Account.AccountNumber__c';
fieldSec2.editable=true;
fieldSec2.readable=true;
admin.fieldPermissions = new MetadataService.ProfileFieldLevelSecurity[] {fieldSec2} ;
profileSaveResults = service.updateMetadata(new MetadataService.Metadata[] { admin });
if (!profileSaveResults[0].success){
    throw new ExternalObjectException(profileSaveResults[0].errors[0].message);
}
System.System.debug(profileSaveResults);
