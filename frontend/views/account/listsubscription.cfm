<!---

    Slatwall - An Open Source eCommerce Platform
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

--->
<cfparam name="rc.account" type="any" />

<cfoutput>
	<div class="svoaccountlistsubscription">
		<!--- <cfdump var="#rc.account.getSubscriptionUsages()#" top="3" /> --->
		<form name="account" method="post" action="#$.createHREF(filename='my-account')#">
			<input type="hidden" name="slatAction" value="frontend:account.save" />
	
			<table>
				<tr>
					<th>Subscription</th>
					<th>Status</th>
					<th>Expiration Date</th>
					<th>Next Bill Date</th>
					<th>Auto Renew</th>
					<th>Payment Method</th>
					<th>Admin</th>
				</tr>
			
				<cfset local.subscriptionIndex = 0 />
				<cfloop array="#rc.account.getSubscriptionUsages()#" index="local.subscriptionUsage">
					<cfset local.subscriptionIndex++ />
					<tr>
						<td>#local.subscriptionUsage.getSubscriptionOrderItemName()#</td>
						<td>#local.subscriptionUsage.getCurrentStatusType()#</td>
						<td>#local.subscriptionUsage.getFormattedValue('expirationDate')#</td>
						<td>#local.subscriptionUsage.getFormattedValue('nextBillDate')#</td>
						<td>#local.subscriptionUsage.getFormattedValue('autoPayFlag')#</td>
						<td>
							<select name="subscriptionUsages[#local.subscriptionIndex#].accountPaymentMethod.accountPaymentMethodID">
								<cfloop array="#rc.account.getAccountPaymentMethodsOptions()#" index="local.accountPaymentMethod">
									<option value="#local.accountPaymentMethod['value']#" <cfif !isNull(local.subscriptionUsage.getAccountPaymentMethod()) && local.subscriptionUsage.getAccountPaymentMethod().getAccountPaymentMethodID() eq local.accountPaymentMethod['value']></cfif>>#local.accountPaymentMethod['name']#</option>
								</cfloop>
							</select>
							<button type="submit">Update Payment Method</button>
						</td>
						<td><a href="#$.createHREF(filename='my-account', queryString='slatAction=frontend:account.renewsubscription&subscriptionUsageID=#local.subscriptionUsage.getSubscriptionUsageID()#')#">Renew Now</a></td>
					</tr>
				</cfloop>
			</table>
		</form>
	</div>
</cfoutput>
