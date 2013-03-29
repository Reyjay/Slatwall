﻿/*

    Slatwall - An e-commerce plugin for Mura CMS
    Copyright (C) 2011 ten24, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Notes:

*/
component displayname="EmailTemplate" entityname="SlatwallEmailTemplate" table="SlatwallEmailTemplate" persistent="true" accessors="true" extends="HibachiEntity" hb_serviceName="templateService" hb_permission="this" {
	
	// Persistent Properties
	property name="emailTemplateID" ormtype="string" length="32" fieldtype="id" generator="uuid" unsavedvalue="" default="";
	property name="emailTemplateName" ormtype="string";
	property name="emailTemplateObject" ormtype="string" hb_formFieldType="select";
	property name="emailTemplateFile" ormtype="string" hb_formFieldType="select";
	property name="emailBodyHTML" ormtype="string" length="4000";
	property name="emailBodyText" ormtype="string" length="4000";
	
	// Related Object Properties (many-to-one)
	
	// Related Object Properties (one-to-many)
	
	// Related Object Properties (many-to-many)
	
	// Remote Properties
	property name="remoteID" ormtype="string";
	
	// Audit Properties
	property name="createdDateTime" hb_populateEnabled="false" ormtype="timestamp";
	property name="createdByAccount" hb_populateEnabled="false" cfc="Account" fieldtype="many-to-one" fkcolumn="createdByAccountID";
	property name="modifiedDateTime" hb_populateEnabled="false" ormtype="timestamp";
	property name="modifiedByAccount" hb_populateEnabled="false" cfc="Account" fieldtype="many-to-one" fkcolumn="modifiedByAccountID";
	
	// Non-Persistent Properties
	property name="emailTemplateObjectOptions" persistent="false";
	property name="emailTemplateFileOptions" persistent="false";

	
	// ============ START: Non-Persistent Property Methods =================
	
	public array function getEmailTemplateObjectOptions() {
		if(!structKeyExists(variables, "emailTemplateObjectOptions")) {
			var emd = getService("hibachiService").getEntitiesMetaData();
			var enArr = listToArray(structKeyList(emd));
			arraySort(enArr,"text");
			variables.emailTemplateObjectOptions = [{name=getHibachiScope().rbKey('define.select'), value=''}];
			for(var i=1; i<=arrayLen(enArr); i++) {
				arrayAppend(variables.emailTemplateObjectOptions, {name=rbKey('entity.#enArr[i]#'), value=enArr[i]});
			}
		}
		return variables.emailTemplateObjectOptions;
	}
	
	public array function getEmailTemplateFileOptions() {
		if(!structKeyExists(variables, "emailTemplateFileOptions")) {
			variables.emailTemplateFileOptions = getService("templateService").getTemplateFileOptions( templateType="email", objectName=getEmailTemplateObject() );
			arrayPrepend(variables.emailTemplateFileOptions, {name=getHibachiScope().rbKey('define.none'), value=''});
		}
		return variables.emailTemplateFileOptions;
	}
	
	// ============  END:  Non-Persistent Property Methods =================
		
	// ============= START: Bidirectional Helper Methods ===================
	
	// =============  END:  Bidirectional Helper Methods ===================

	// ================== START: Overridden Methods ========================
	
	public any function getEmailBodyHTML() {
		if(!structKeyExists(variables, "emailBodyHTML")) {
			variables.emailBodyHTML = "";
		}
		return variables.emailBodyHTML;
	}
	
	public any function getEmailBodyText() {
		if(!structKeyExists(variables, "emailBodyText")) {
			variables.emailBodyText = "";
		}
		return variables.emailBodyText;
	}
	
	// ==================  END:  Overridden Methods ========================
	
	// =================== START: ORM Event Hooks  =========================
	
	// ===================  END:  ORM Event Hooks  =========================
}