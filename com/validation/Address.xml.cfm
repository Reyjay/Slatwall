<?xml version="1.0" encoding="UTF-8"?>
<validateThis xsi:noNamespaceSchemaLocation="validateThis.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<contexts>
		<context name="save" />
		<context name="delete" />
		<context name="edit" />
	</contexts>
	<objectProperties>
		<property name="country">
			<rule type="required" contexts="save,full" />
		</property>
		<property name="name">
			<rule type="required" contexts="full" />
		</property>
	</objectProperties>
</validateThis>