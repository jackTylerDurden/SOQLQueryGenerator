public with sharing class SOQLQueryGeneratorCtrl {
   

	//Map<String,SobjectType> objectList {get;set;}
	public static final Map<String,SobjectType> objectsInfo = Schema.getGlobalDescribe();

	@RemoteAction
	public static Map<String,object> initObjects(){
		//objectsInfo = Schema.getGlobalDescribe();
		System.debug('objectsInfo-->>'+objectsInfo);
		Map<String,Object> resultMap;
		List<object> resultList = new List<object>();
		List<String> objectList = new List<String>();	
		Map<String,Object> result = new Map<String,Object>();	
		//system.debug('objectList------->>>>'+objectList);
		System.debug('objectList------->>>>'+ objectsInfo.keySet().size());
		for(String key : objectsInfo.keySet()){
			//System.debug('objectsInfo->>>'+objectsInfo.get(key).getDescribe());
			System.debug('key------<<<'+key);
			Schema.DescribeSObjectResult sobjectResult = objectsInfo.get(key).getDescribe();
			resultMap = new Map<String,Object>();	
			resultMap.put('ObjectApiName',sobjectResult.getName());
			resultMap.put('ObjectLabel',sobjectResult.getLabel());
			resultMap.put('isCreateable',sobjectResult.isCreateable());
			resultMap.put('isUpdateable',sobjectResult.isUpdateable());
			resultMap.put('isQueryable',sobjectResult.isQueryable());
			resultList.add(resultMap);
				
		}		
		result.put('InitObjectInfo',resultList);
		System.debug('result------->>>>'+ result);
		return result;	
	}

	@RemoteAction
	public static Map<String,Object> fetchFields(Map<String,Object> paramMap){
		System.debug('paramMap----->>>'+paramMap);
		Map<String,Object> result = new Map<String,Object>();
		List<Object> resultList = new List<object>();
		String objectApiName = String.valueOf(paramMap.get('ObjectApiName')).toLowerCase();
		System.debug('objectApiName----<<<'+objectApiName);
		SobjectType objectType = objectsInfo.get(objectApiName);
		Map<String,Schema.SObjectField> fieldInfoMap = new Map<String,Schema.SObjectField>();		
		fieldInfoMap = objectType.getDescribe().fields.getMap();
		for(String key : fieldInfoMap.keySet()){
			Schema.DescribeFieldResult fieldInfo = fieldInfoMap.get(key).getDescribe();
			Map<String,Object> resultMap = new Map<String,Object>();
			resultMap.put('fieldApiName',fieldInfo.getName());
			resultMap.put('fieldLabel',fieldInfo.getLabel());
			resultMap.put('isChecked',false);
			resultList.add(resultMap);
		}
		result.put('FieldsInfo',resultList);
		return result;
	}

	


	public SOQLQueryGeneratorCtrl() {				
	}	
}