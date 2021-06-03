@RestResource(urlMapping='/SurveyLink/*')
global with sharing class SurveyInvitationGenerator {
    
    @HttpPost
    global static String doPost(String contactId, String surveyId, String communityId) {
        SurveyInvitation si = new SurveyInvitation();
        si.CommunityId = communityId;
        si.ParticipantId = contactId;
        si.SurveyId = surveyId;
        si.Name = contactId+'NPS'+DateTime.now();
        si.OptionsAllowGuestUserResponse = true;
        
        insert si;
        
        SurveySubject ss = new SurveySubject();
        ss.SubjectId = contactId;
        ss.ParentId = si.Id;
        ss.Name = contactId+'NPSSubject'+DateTime.now();
        
        SurveyInvitation nsi = [SELECT InvitationLink from SurveyInvitation WHERE Id=:si.Id];
        
        return nsi.InvitationLink;
    }
}