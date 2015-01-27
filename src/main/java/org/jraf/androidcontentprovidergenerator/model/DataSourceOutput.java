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

package org.jraf.androidcontentprovidergenerator.model;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.jraf.androidcontentprovidergenerator.Arguments;
import org.jraf.androidcontentprovidergenerator.Main.Json;
import org.json.JSONException;
import org.json.JSONObject;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * @author Dell990MT
 *
 */
public class DataSourceOutput {
	
	public void generateOutput(Configuration freeMarkerConfig, Arguments arguments, JSONObject config, Entity entity) throws IOException, JSONException, TemplateException {
		final String providerJavaPackage = config.getString(Json.PROVIDER_JAVA_PACKAGE);
        final File providerDir = new File(arguments.outputDir, providerJavaPackage.replace('.', '/'));
        final Map<String, Object> root = new HashMap<>();
        root.put("config", config);
        root.put("header", Model.get().getHeader());
        root.put("model", Model.get());
        root.put("entity", entity);

        final File outputDir = new File(providerDir, entity.getPackageName());
        outputDir.mkdirs();
        final File baseClassesDir = new File(providerDir, "base");
        baseClassesDir.mkdirs();

        Template template;
        File outputFile;
        
        // Cursor wrapper
        outputFile = new File(outputDir, entity.getNameCamelCase() + "Cursor.java");
        template = freeMarkerConfig.getTemplate("cursor.ftl");
        DataSourceOutput.writeOutput(template, outputFile, root);

        // ContentValues wrapper
        outputFile = new File(outputDir, entity.getNameCamelCase() + "ContentValues.java");
        template = freeMarkerConfig.getTemplate("contentvalues.ftl");
        DataSourceOutput.writeOutput(template, outputFile, root);

        // Selection builder
        outputFile = new File(outputDir, entity.getNameCamelCase() + "Selection.java");
        template = freeMarkerConfig.getTemplate("selection.ftl");
        DataSourceOutput.writeOutput(template, outputFile, root);

        // Enums (if any)
        for (Field field : entity.getFields()) {
            if (field.isEnum()) {
                outputFile = new File(outputDir, field.getEnumName() + ".java");
                root.put("field", field);
                template = freeMarkerConfig.getTemplate("enum.ftl");
                DataSourceOutput.writeOutput(template, outputFile, root);
            }
        }
	}

    private static HashMap<File, Boolean> cachedOutput = new HashMap<File, Boolean>();
    
	public static void writeOutput(Template template, File outputFile, Map<String, Object> root) throws TemplateException, IOException {
		Boolean cached = cachedOutput.get(outputFile);
		if (null == cached) {
	        Writer out = new OutputStreamWriter(new FileOutputStream(outputFile));
	        template.process(root, out);
	        IOUtils.closeQuietly(out);
	        cachedOutput.put(outputFile, true);
		}
	}
}
