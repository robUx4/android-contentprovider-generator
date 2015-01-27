/*
 * This source is part of the
 *      _____  ___   ____
 *  __ / / _ \/ _ | / __/___  _______ _
 * / // / , _/ __ |/ _/_/ _ \/ __/ _ `/
 * \___/_/|_/_/ |_/_/ (_)___/_/  \_, /
 *                              /___/
 * repository.
 * 
 * Copyright (C) 2012-2014 Benoit 'BoD' Lubek (BoD@JRAF.org)
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package org.jraf.androidcontentprovidergenerator;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.jraf.androidcontentprovidergenerator.Main.Json;
import org.jraf.androidcontentprovidergenerator.model.DataSourceOutput;
import org.jraf.androidcontentprovidergenerator.model.Entity;
import org.jraf.androidcontentprovidergenerator.model.Model;
import org.json.JSONException;
import org.json.JSONObject;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * @author Dell990MT
 *
 */
public class ContentProviderSourceOutput extends DataSourceOutput {
	
	@Override
	public int hashCode() {
		return ContentProviderSourceOutput.class.hashCode();
	}

	public void generateOutput(Configuration freeMarkerConfig, Arguments arguments, JSONObject config, Entity entity) throws IOException, JSONException, TemplateException {
		super.generateOutput(freeMarkerConfig, arguments, config, entity);
		
		final String providerJavaPackage = config.getString(Json.PROVIDER_JAVA_PACKAGE);
        final Map<String, Object> root = new HashMap<>();
        root.put("config", config);
        root.put("header", Model.get().getHeader());
        root.put("model", Model.get());
        root.put("entity", entity);

        final File providerDir = new File(arguments.outputDir, providerJavaPackage.replace('.', '/'));
        providerDir.mkdirs();
        final File outputDir = new File(providerDir, entity.getPackageName());
        outputDir.mkdirs();
        final File baseClassesDir = new File(providerDir, "base");
        baseClassesDir.mkdirs();

        Template template;
        File outputFile;
        
        template = freeMarkerConfig.getTemplate("contentprovider.ftl");
        outputFile = new File(providerDir, config.getString(Json.PROVIDER_CLASS_NAME) + ".java");
        DataSourceOutput.writeOutput(template, outputFile, root);

        // BaseContentProvider
        template = freeMarkerConfig.getTemplate("basecontentprovider.ftl");
        outputFile = new File(baseClassesDir, "BaseContentProvider.java");
        DataSourceOutput.writeOutput(template, outputFile, root);
        
        template = freeMarkerConfig.getTemplate("abstractcpdatasource.ftl");
        outputFile = new File(baseClassesDir, "AbstractContentProviderDataSource.java");
        DataSourceOutput.writeOutput(template, outputFile, root);

        template = freeMarkerConfig.getTemplate("abstractelementhandler.ftl");
        outputFile = new File(baseClassesDir, "DatabaseModelHandler.java");
        DataSourceOutput.writeOutput(template, outputFile, root);


        // Model
        template = freeMarkerConfig.getTemplate("model.ftl");
        outputFile = new File(outputDir, entity.getNameCamelCase() + "Model.java");
        DataSourceOutput.writeOutput(template, outputFile, root);

        template = freeMarkerConfig.getTemplate("modelimpl.ftl");
        outputFile = new File(outputDir, entity.getNameCamelCase() + "Impl.java");
        DataSourceOutput.writeOutput(template, outputFile, root);

        template = freeMarkerConfig.getTemplate("modelkey.ftl");
        outputFile = new File(outputDir, entity.getNameCamelCase() + "Key.java");
        DataSourceOutput.writeOutput(template, outputFile, root);
        
        template = freeMarkerConfig.getTemplate("modelkeyimpl.ftl");
        outputFile = new File(outputDir, entity.getNameCamelCase() + "KeyImpl.java");
        DataSourceOutput.writeOutput(template, outputFile, root);
        
        template = freeMarkerConfig.getTemplate("modelvalue.ftl");
        outputFile = new File(outputDir, entity.getNameCamelCase() + "Value.java");
        DataSourceOutput.writeOutput(template, outputFile, root);
        
        template = freeMarkerConfig.getTemplate("modelvalueimpl.ftl");
        outputFile = new File(outputDir, entity.getNameCamelCase() + "ValueImpl.java");
        DataSourceOutput.writeOutput(template, outputFile, root);
        
        template = freeMarkerConfig.getTemplate("invalidkey.ftl");
        outputFile = new File(outputDir, entity.getNameCamelCase() + "InvalidKey.java");
        DataSourceOutput.writeOutput(template, outputFile, root);

        template = freeMarkerConfig.getTemplate("cpdatasource.ftl");
        outputFile = new File(outputDir, entity.getNameCamelCase() + "ContentProviderDataSource.java");
        DataSourceOutput.writeOutput(template, outputFile, root);

        template = freeMarkerConfig.getTemplate("abstractserializer.ftl");
        outputFile = new File(outputDir, entity.getNameCamelCase() + "DatabaseSerializer.java");
        DataSourceOutput.writeOutput(template, outputFile, root);

        template = freeMarkerConfig.getTemplate("elementhandler.ftl");
        outputFile = new File(outputDir, entity.getNameCamelCase() + "DatabaseModelHandler.java");
        DataSourceOutput.writeOutput(template, outputFile, root);
	}
}
