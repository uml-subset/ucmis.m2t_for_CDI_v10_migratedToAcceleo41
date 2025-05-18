package ucmis.m2t.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
//import java.util.ArrayList;
//import java.util.Hashtable;
//import java.util.List;
import java.io.*;
//import java.util.Arrays;
import java.util.Properties;

import org.eclipse.emf.ecore.EModelElement;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.xmi.XMIResource;
import org.eclipse.uml2.uml.Property;

//import org.eclipse.emf.ecore.util.EcoreUtil;
//import org.eclipse.emf.ecore.EObject;

public class utilityServices {
//  	public List<String> allProperties() {
		public Properties allProperties() {
			FileInputStream in;
			Properties p = new Properties();
//ok		Properties p = System.getProperties();
			try{
				in = new FileInputStream("src/ucmis/m2t/property/ddicdi2.properties");
//				in = new FileInputStream("E:\\Git\\ucmis.m2t\\src\\ucmis\\m2t\\property\\ddicdi2.properties");
				p.load(in);
				}
			catch(IOException e){
				System.out.println(e.getMessage());
				}
//		Hashtable<Object,Object> hashtable = System.getProperties();
//		p.forEach( (k, v) -> );
//		List<String> listValues = new List<String>( p.values() );
//		List<String> listValues = new ArrayList<String>( p.values() );
		return p;
//		return listValues; 
	}
		public Properties allPropertiesJavaService(Object object){return allProperties();}
	public String getCurrentTime() {
		return DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(LocalDateTime.now());
	}
	public String getCurrentTimeJavaService(Object object){return getCurrentTime();}
	public String getXmiId(EModelElement anEModelElement) {
	    if (anEModelElement.eResource() instanceof XMIResource) {
	        return ((XMIResource)anEModelElement.eResource()).getID(anEModelElement);
	    }
	    return "";
	}
	public String getXmiIdJavaService(EModelElement anEModelElement){return getXmiId(anEModelElement);}
	 
	public String getCardinality(EModelElement anEModelElement) {
		EObject eObject = (EObject) anEModelElement;
		if (eObject.eClass().getName().equals("Property")) {
			Property aProperty = (Property) eObject;
			if (aProperty.lowerBound() == 0 & aProperty.upperBound() == 1) {
				return "?";
			} else if (aProperty.lowerBound() == 0 & aProperty.upperBound() == -1) {
				return "*";
			} else if (aProperty.lowerBound() == 1 & aProperty.upperBound() == -1) {
				return "+";
			} else
				return "";
		} else
			return "";
	}
	public String getCardinalityJavaService(EModelElement anEModelElement){return getCardinality(anEModelElement);}
}
