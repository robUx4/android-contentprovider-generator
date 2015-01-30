<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import android.support.annotation.NonNull;

import ${config.providerJavaPackage}.base.DatabaseModelHandler;
import ${config.providerJavaPackage}.base.DatabaseSerializer;

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * Database model handler for the {@code ${entity.nameLowerCase}} table.
</#if>
 * <p>Used to read/write {@link ${entity.nameCamelCase}Model} into a database
 * and select items using a {@link ${config.providerJavaPackage}.${entity.packageName}.${entity.nameCamelCase}Selection}</p>
 */
public class ${entity.nameCamelCase}DatabaseModelHandler extends DatabaseModelHandler<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor, ${entity.nameCamelCase}Selection> {
    /**
     * Default Constructor.
     */
    public ${entity.nameCamelCase}DatabaseModelHandler() {
        this(${entity.nameCamelCase}DatabaseSerializer.INSTANCE);
    }

    /**
     * Constructor.
     *
     * @param serializer transforms a {@link ${entity.nameCamelCase}Cursor} to a {@link ${entity.nameCamelCase}Model}
     *                   or a {@link ${entity.nameCamelCase}Model} into {@code ContentValues}
     * @see ${entity.nameCamelCase}DatabaseSerializer
     */
    public ${entity.nameCamelCase}DatabaseModelHandler(DatabaseSerializer<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor> serializer) {
        super(serializer);
    }

    @Override
    protected ${entity.nameCamelCase}Selection getItemSelection(@NonNull ${entity.nameCamelCase}Model itemToSelect) {
        return new ${entity.nameCamelCase}Selection(itemToSelect);
    }
}